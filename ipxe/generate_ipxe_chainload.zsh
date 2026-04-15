#!/usr/bin/zsh -e
pxe_assets_dir="/var/www/html/pxe"
pxe_chain_machine_specific=${pxe_assets_dir}/machine-specific-chain.ipxe
pxe_machine_default=${pxe_assets_dir}/machine-default.ipxe
if [[ ! -d "${pxe_assets_dir}" ]] ; then
    mkdir "${pxe_assets_dir}"
fi

ipxe_modules=(
    http://boot.ipxe.org/undionly.kpxe
    http://boot.ipxe.org/x86_64-efi/ipxe.efi
)

for pxe_module in ${ipxe_modules[@]} ; do
    module_fqdn="${pxe_assets_dir}/$(basename "${pxe_module}")"
    if [[ ! -f "${module_fqdn}" ]] ; then
        (
            set -x
            curl -s --output "${module_fqdn}" "${pxe_module}"
        )
    fi
done

if [[ -z "${TFTP_SERVER_ADDRESS}" ]] ; then
    cat <<EOF >&2
TFTP_SERVER_ADDRESS environment variable must be passed to container.
This variable shoud contain protocol and server address to access ipxe files.

Sample launch podman command:
podman run -it --rm  -v /home/pxeuser/assets:/var/www/html --name ipxe -p 69:8069/udp -p 80:8080 --env "TFTP_SERVER_ADDRESS=http://mypxe.local" quay.io/simbelmas/ipxe:stable manage_assets
EOF
    exit 2
fi

temp_ipxe_chain_specific=$(mktemp)

cat <<EOF >${temp_ipxe_chain_specific}
#!ipxe

set CHAINURL ${TFTP_SERVER_ADDRESS}/host/\${hostname}.\${domain}/launch.ipxe

echo 
dhcp

echo
echo Booting pxe from \${filename}
echo Will chain to \${CHAINURL}
echo 
sleep 5

chain \${CHAINURL}
EOF

if [[ ! -f "${pxe_chain_machine_specific}" ]] || [[ "$(sha256sum "${pxe_chain_machine_specific}" | cut -f1 -d' ')" != "$(sha256sum "${temp_ipxe_chain_specific}" | cut -f1 -d' ')" ]] ; then
    cp -v "${temp_ipxe_chain_specific}" "${pxe_chain_machine_specific}"
    chmod a+r "${pxe_chain_machine_specific}"
fi
rm "${temp_ipxe_chain_specific}"

## Creating default configuration that does nothing
temp_default_chain=$(mktemp)

cat <<EOF >${temp_default_chain}
#!ipxe

echo
echo Loaded default configuration
echo This configuration does nothing but reboot after 5 seconds

sleep 5
reboot
EOF

if [[ ! -f "${pxe_machine_default}" ]] || [[ "$(sha256sum "${pxe_machine_default}" | cut -f1 -d' ')" != "$(sha256sum "${temp_default_chain}" | cut -f1 -d' ')" ]] ; then
    cp -v "${temp_default_chain}" "${pxe_machine_default}"
    chmod a+r "${pxe_machine_default}"
fi
rm "${temp_default_chain}"


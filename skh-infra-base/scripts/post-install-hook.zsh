#!/bin/bash -e

export tftp_server_name=filia.skh.spdnova.xyz
export current_hostname=$(hostname -f)
export tftp_server_host_url="http://${tftp_server_name}/host/${current_hostname}"
export tftp_server_host_secret_url="http://${tftp_server_name}/host/${current_hostname}/secret"

tftp_server_ip=$(dig +short ${tftp_server_name} | cut -f1 -d' ' | head -n1)

if [[ -z "${tftp_server_ip}" ]] ; then
    echo "Did not succeeded to grad tftp server ip, exiting ..." >&2
    exit 1
fi

if [[ "$(ip -o link show up | grep -v 'lo:' | wc -l)" -gt 1 ]] && [[ -z "$(ip -o link show up | grep bond)" ]]; then
    echo "More than one interface detected and no bonding setted up, identifying first and disabling others" 
    pxe_src_iface=$(ip -o link show | awk -F ': ' '$2 != "lo" {print $2 ; exit }')
    ## Disabling other interfaces
    for iface in $(ip -o link show up | grep -Ev "lo:|${pxe_src_iface}:" | awk -F ': ' '$2 != "lo" {print $2}') ; do
        echo Set ${iface} down.
        nmcli con down ${iface} || echo Interface already down.
    done
    echo Switching primary interface down/up to refresh configuration.
    (
        set +e
        nmcli con down ${pxe_src_iface}
        nmcli con up ${pxe_src_iface}
    ) 
elif [[ -n "$(ip -o address | grep "${tftp_server_ip}")" ]]
    # case of the server itself, the tftp server ip is worn by the machine
    pxe_src_iface=$( ip -o address | awk "\$0 ~ /${tftp_server_ip}/ {print \$2;}")
else
    pxe_src_iface=$(ip route get ${tftp_server_ip} | grep -oP 'dev \K\S+')
fi

pxe_src_ip=$(ip -o address show dev ${pxe_src_iface} | grep -oP 'inet \K[0-9.]+')
pxe_src_mac=$( ip -o link show ${pxe_src_iface} | grep -oP 'link/ether \K\S+' | tr '[:lower:]' '[:upper:]')

echo "Using reference interface ${pxe_src_iface} with ip ${pxe_src_ip} and mac ${pxe_src_mac}"

if [[ -z "${pxe_src_ip}" ]] || [[ -z "${pxe_src_iface}" ]] || [[ -z "${pxe_src_mac}" ]] ; then
    echo "Did not succeeded to identify principal interface/ip/mac, exiting ..." >&2
    exit 1
fi

export pxe_src_mac

temp_post_install=$(mktemp)
set -x
if ! curl --silent --fail "${tftp_server_host_secret_url}/post-install.sh?mac=${pxe_src_mac}" -o ${temp_post_install} ; then
    echo Failed to get post install script, exiting ... >&2
    exit 2
fi

chmod u+x ${temp_post_install}
${temp_post_install}

# Cleanup
rm ${temp_post_install}

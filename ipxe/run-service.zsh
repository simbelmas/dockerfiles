#!/usr/bin/zsh -e
## Reexport env vars
sudo_preserve_env=TFTP_SERVER_ADDRESS
case "${1}" in
    ipxe)
        set -x
        nginx -g "daemon off;" &
        dnsmasq --keep-in-foreground &
        wait
        ;;
    manage_assets)
        /var/www/generate_ipxe_chainload.zsh
        /var/www/get_pxe_fedora_coreos.zsh
        ;;
    *)
        echo "Service must be specified:"
        echo "- ipxe"
        echo "- manage_assets"
        exit 1
        ;;
esac
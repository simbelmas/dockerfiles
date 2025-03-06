#!/usr/bin/zsh -e
## Reexport env vars
sudo_preserve_env=TFTP_SERVER_ADDRESS
case "${1}" in
    ipxe)
        set -x
        sudo -u app nginx -g "daemon off;" &
        busybox syslogd -n -O /dev/stdout &
        /usr/sbin/in.tftpd --foreground --secure --user app  --ipv4 --blocksize 1468 -vvv --address 0.0.0.0:8069 /var/www/html/
        ;;
    manage_assets)
        sudo -u app --preserve-env=${sudo_preserve_env} /var/www/generate_ipxe_chainload.zsh
        sudo -u app --preserve-env=${sudo_preserve_env} /var/www/get_pxe_fedora_coreos.zsh
        ;;
    *)
        echo "Service must be specified:"
        echo "- webserver"
        echo "- tftp"
        echo "- manage_assets"
        exit 1
        ;;
esac
#!/bin/bash -e

export tftp_server_name=filia.skh.spdnova.xyz
export current_hostname=sacha-pc.skh.spdnova.xyz
tftp_server_ip=$(dig +short ${tftp_server_name})

if [[ -z "${tftp_server_ip}" ]] ; then
    echo "Did not succeeded to grad tftp server ip, exiting ..." >&2
    exit 1
fi

pxe_src_iface=$(ip route get ${tftp_server_ip} | grep -oP 'dev \K\S+')
pxe_src_ip=$(ip route get ${tftp_server_ip} | grep -oP 'src \K\S+')

if [[ -z "${pxe_src_ip}" ]] || [[ -z "${pxe_src_iface}" ]] ; then
    echoo "Did not succeeded to identify principal interface/ip, exiting ..." >&2
    exit 1
fi

if ! pxe_src_mac=$(ip link show ${pxe_src_iface} | grep -oP 'link/\S+ \K\S+' | tr '[:lower:]' '[:upper:]' ) || [[ -z "${pxe_src_mac}" ]] ; then
    echo "Did not succeeded to identify principal interface mac, exiting ..." >&2
    exit 1
fi
export pxe_src_mac

set -x

temp_post_install=$(mktemp)
if ! curl --silent --fail "http://${tftp_server_ip}/host/${current_hostname}/secret/post-install.sh?mac=${pxe_src_mac}" -o ${temp_post_install} ; then
    echo Failed to get post install script, exiting ... >&2
    exit 2
fi

chmod u+x ${temp_post_install}
${temp_post_install}

# Cleanup
rm ${temp_post_install}

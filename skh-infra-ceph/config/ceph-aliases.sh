alias zap-disks-with-ceph="cephadm shell  --mount /usr/local/bin:/usr/local/bin -- /usr/local/bin/zap-host-disks.sh"
ceph() {
    cephadm shell -- ceph "${@}" 2> >(grep -v 'Inferring' >&2)
}
rados() {
    cephadm shell -- rados "${@}" 2> >(grep -v 'Inferring' >&2)
}
rbd() {
    cephadm shell -- rbd "${@}" 2> >(grep -v 'Inferring' >&2)
}

zap-disk-whitout-ceph () {
    zap_device=${1:-}
    read zd zvg < <(pvs --separator ' ' | grep -oP "${zap_device} \S+")
    if [[ -z "${zd}" ]] || [[ -z "${zvg}" ]] ; then
        echo the provided devices didnt mapped a ceph disk, exiting.
    else
    (
        set -x
        vgchange -an ${zvg}
        wipefs --all ${zd}
    )
fi
}

watchceph () {
  watch "source /etc/profile.d/ceph-aliases.sh ; $@"
}

wcs () {
  watchceph ceph status
}
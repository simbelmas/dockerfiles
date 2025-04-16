## Define utility function for version compare
verlte() { 
    printf '%s\n%s' "$1" "$2" | sort -c -V
}
verlt() { 
    printf '%s\n%s' "$1" "$2" | sort -c -V
    comp_result=$?
    if [[ "$1" != "$2" ]] ; then
        return ${comp_result}
    else
        return 1
    fi
}
update_file_if_changed() {
    local source_file=${1}
    local dest_file=${2}
    if [[ ! -e "${source_file}" ]] ; then
        echo "Source file '${source_file}' must exist, exiting ..."
        return 1
    fi
    (
        set -x
        rsync --verbose --checksum --recursive --perms --acls --xattrs --owner --group --links --executability --itemize-changes "${source_file}" "${dest_file}"
        restorecon -R "${dest_file}"
    )
}
manage_reboot_lease_nonblocking() {
    local group
    local systemd_id128_zincati_machineid
    local endpoint='https://skh.fleetlock.soket.fr'

    if [[ "$1" != "recursive-lock" ]] && [[ "$1" != "unlock-if-held" ]] ; then
        echo "please provide command as first parameter: unlock-if-held|recursive-lock" >&2
        return 1
    else
        command="$1"
    fi
    if [[ -z "${2}" ]] ; then
        echo "Second parameter must be lease group complying with dns name convention." >&2
    else
        group="${2}"
    fi

    #https://github.com/lucab/zincati/blob/17d5e2adf13ee9a98cebc662735a2084949e589b/src/identity/mod.rs#L9
    systemd_id128_zincati_machineid=$(systemd-id128 machine-id -a de35106b6ec24688b63afddaa156679b)
    podman run --network=host --rm quay.io/simbelmas/fleetlock-client:stable "${command}" --group="${group}" --url="${endpoint}" --id="${systemd_id128_zincati_machineid}"
    return $?
}
request_reboot_lease_nonblocking() {
    manage_reboot_lease_nonblocking recursive-lock "${1}"
}
release_reboot_lease_nonblocking() {
    manage_reboot_lease_nonblocking unlock-if-held "${1}"
}
request_reboot_lease() {
    local poll_sec=10
    if [[ -z "$1" ]] ; then
        echo "Group must be passed as first argument" >&2
        return 1
    fi

    while ! $(request_reboot_lease_nonblocking "${1}") ; do
        echo "$(date): Cannot obtain reboot lease, wait ${poll_sec} to retry" >&2
        sleep ${poll_sec}
    done
}

release_reboot_lease(){
    local poll_sec=10
    if [[ -z "$1" ]] ; then
        echo "Group must be passed as first argument" >&2
        return 1
    fi

    while ! $(manage_reboot_lease_nonblocking unlock-if-held "${1}") ; do
        echo "$(date): Cannot obtain reboot lease, wait ${poll_sec} to retry" >&2
        sleep ${poll_sec}
    done    
}
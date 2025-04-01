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
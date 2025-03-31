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
    if [[ ! -f "${source_file}" ]] ; then
        echo "Source file '${source_file}' must exist, exiting ..."
        return 1
    fi
    if [[ ! -f "${dest_file}" ]] ; then
        cp -av "${source_file}" "${dest_file}"
    fi
    if [[ "$(sha256sum "${source_file}" | cut -f1 -d' ')" != "$(sha256sum "${dest_file}" | cut -f1 -d' ')" ]] ; then
        cp -afv "${source_file}" "${dest_file}"
    fi
}
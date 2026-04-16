#!/usr/bin/zsh

set -e

if [[ -z "${ASSETS_DIR}" ]] ; then
    echo "'ASSETS_DIR' environment variable must be set to a directory available through pxe"
    exit 1
else

    assets_dir=${ASSETS_DIR}
fi

fedora_active_versions_info_reverse_ordered=$(curl -s https://admin.fedoraproject.org/pkgdb/api/collections/ | jq '.collections | map(select(.status == "Active")) | map(select(.name == "Fedora Linux")) | sort_by(.version) | reverse')

pxe_files=(
    images/pxeboot/initrd.img
    images/pxeboot/vmlinuz
    images/install.img
)
keep_releases=2
mirrored_arches=(
    x86_64
    #aarch64
)

if [[ ! -d "${assets_dir}" ]] ; then
    mkdir -p "${assets_dir}"
fi

## download all active versions
for active_version in $(echo ${fedora_active_versions_info_reverse_ordered} | jq -r ".[0:$((keep_releases))] | .[].version") ; do
    version_dir=${assets_dir}/${active_version}
    if [[ ! -d "${version_dir}" ]] ; then
        mkdir "${version_dir}"
    fi
    for arch in "${mirrored_arches[@]}" ; do
        current_version_arch_dir=${version_dir}/${arch}
        if [[ ! -d "${current_version_arch_dir}" ]] ; then
            mkdir "${current_version_arch_dir}"
        fi
        download_base_url="https://download.fedoraproject.org/pub/fedora/linux/releases/${active_version}/Everything/${arch}/os"

        for pxe_file in "${pxe_files[@]}" ; do
            file_url=${download_base_url}/${pxe_file}
            file_canonicalname="${current_version_arch_dir}/${pxe_file}"
            file_dir="$(dirname "${file_canonicalname}")"
            if [[ ! -e "${file_dir}" ]] ; then
                mkdir -p "${file_dir}"
            fi
            if [[ ! -f "${file_canonicalname}" ]] ; then
                (
                    set -x
                    curl -s --output "${file_canonicalname}" --location "${file_url}"
                )
            fi
        done
    done
done

echo "Done downloading, ... cleaning up"
## cleanup

downloaded_versions=$(find "${assets_dir}" -mindepth 1 -maxdepth 1 -type d | sort -rdu)
kept_versions="$(echo "${downloaded_versions}" | head -n ${keep_releases})"

delete_versions="${downloaded_versions}"
for kept_version in ${=kept_versions} ; do
    delete_versions="$(echo "${delete_versions}" | grep -v "${kept_version}" || continue)"
done

echo downloadded ${downloaded_versions}
echo kept ${kept_versions}
echo delete ${delete_versions}

if [[ -n "${delete_versions}" ]] ; then
    for delete_version in ${=delete_versions} ; do
        rm -rf ${delete_version}
    done
fi

echo ${fedora_active_versions_info_reverse_ordered} | jq -r '.[0].version' > ${assets_dir}/fedora_latest_version
echo -e "\nAvailable versions:\n${kept_versions} "
echo -e "\nLatest version: $(cat ${assets_dir}/fedora_latest_version)"

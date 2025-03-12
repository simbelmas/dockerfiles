#!/usr/bin/zsh -e

coreos_assets_dir="/var/www/html/coreos"
coreos_stream=stable
coreos_latest_stream_version_details=https://builds.coreos.fedoraproject.org/streams/${coreos_stream}.json

pxe_files=(
    kernel
    initramfs
    rootfs
)
keep_releases=3
mirrored_arches=(
    x86_64
    aarch64
)

if [[ ! -d "${coreos_assets_dir}" ]] ; then
    mkdir "${coreos_assets_dir}"
fi

latest_stream_build_details="$( curl -s ${coreos_latest_stream_version_details} )"

coreos_release=$(echo ${latest_stream_build_details} | jq '.architectures.x86_64.artifacts.metal.release')

for arch in "${mirrored_arches[@]}" ; do
    for pxe_file in "${pxe_files[@]}" ; do
        file_url="$(echo ${latest_stream_build_details} | jq -r ".architectures.${arch}.artifacts.metal.formats.pxe.${pxe_file}.location")"
        file_sha256="$(echo ${latest_stream_build_details} | jq -r ".architectures.${arch}.artifacts.metal.formats.pxe.${pxe_file}.sha256")"
        file_name="$(basename "${file_url}")"
        file_canonicalname="${coreos_assets_dir}/${file_name}"

        if [[ ! -f "${file_canonicalname}" ]] || [[ "$(sha256sum "${file_canonicalname}" | cut -f1 -d' ')" != "${file_sha256}" ]] ; then
            (
                set -x
                curl -s --output "${file_canonicalname}" "${file_url}"
            )
        fi

        if [[ "$(sha256sum "${file_canonicalname}" | cut -f1 -d' ')" != "${file_sha256}" ]] ; then
            echo "File sha256 does not match release provided one, deleting file and exiting ..." >&2
            rm -v "${file_canonicalname}"
            exit 2
        fi

    done
done

## cleanup
downloaded_versions=$(ls -1 "${coreos_assets_dir}" | grep -oE '[0-9]+\.[0-9]+.[0-9]+.[0-9]+' | sort -rdu)
kept_versions="$(echo "${downloaded_versions}" | head -n ${keep_releases})"

delete_versions="${downloaded_versions}"
for kept_version in ${=kept_versions} ; do
    delete_versions="$(echo "${delete_versions}" | grep -v "${kept_version}" || continue)"
done

if [[ -n "${delete_versions}" ]] ; then
    for delete_version in ${=delete_versions} ; do
        rm -v ${coreos_assets_dir}/*${delete_version}*
    done
fi

echo -e "\nAvailable arches:"
ls -1 "${coreos_assets_dir}" | grep -- 'kernel-' | sed -r 's/^.*-([a-zA-Z0-9_]+)$/\1/'

echo -e "\nAvailable versions:\n${kept_versions} "

## Put latest version in file to be used by others scripts
echo "$(echo "${kept_versions}" | head -n 1)" > "${coreos_assets_dir}/coreos_latest_available_version"


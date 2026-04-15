#!/usr/bin/zsh
set -e

if [[ -n "${PXE_CONF_DIR}" ]] ; then
    pxe_conf_dir="${PXE_CONF_DIR}"
else
    pxe_conf_dir=/var/www/html
fi

if [[ -z "${INFRASTRUCTURE_CONFIG_FILENAME}" ]] ; then
    echo "'INFRASTRUCTURE_CONFIG_FILENAME' file must be present at infrastructure definition root with given file name, exiting ..." >&2
    exit 1
fi

if [[ -z "${RUNNING_HOST}" ]] ; then
    echo 'RUNNING_HOST environment variable must be set to be able to do host related stuff' >&2
    exit 1
fi
running_host="${RUNNING_HOST}"

infrastructure_config_file_path="${pxe_conf_dir}/${INFRASTRUCTURE_CONFIG_FILENAME}"

if [[ ! -d "${pxe_conf_dir}" ]] ; then
    echo "PXE config dir '${pxe_conf_dir}' cannot be found, exiting ..." >&2
    exit 1
fi

if [[ -z "${PXE_CONF_GIT}" ]] ; then
    echo "PXE_CONF_GIT var must be set to checkout configuration" >&2
    exit 1
fi

if [[ ! -e "${pxe_conf_dir}" ]] ; then
    echo -n "Created: "
    mkdir -v "${pxe_conf_dir}"
fi

cd "${pxe_conf_dir}"

if ! git status 2>/dev/null 1>&2 ; then
    echo "Directory is not a git repository, initializing ..."
    (
        set -x
        git init
        timeout 20 git remote add origin "${PXE_CONF_GIT}"
    )
fi

attempt=1

set +e
while [[ "${attempt}" -le 1 ]] ; do
    echo Pulling attempt ${attempt} ...
    timeout 20 git pull -f  origin main
    pull_rc=$?
    if [[ "${pull_rc}" != 0 ]] ; then
        sleep 5
    else
        break
    fi
    ((attempt++))
done
set -e

if [[ ${pull_rc} != 0 ]] ; then
    echo "Git update failed, continuing with directory AS IS ..."
else
    echo "Git successfuly updated."
fi

## Chaining to host generation
${pxe_conf_dir}/utilities/generate-hosts-configuration.zsh
${pxe_conf_dir}/utilities/generate-nginx-configuration.zsh
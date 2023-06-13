FROM quay.io/simbelmas/ubuntu:v2304.5@sha256:429439087cd58476727732292b15537a9ef802677eeb2c2ddf7830bef386984f AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apt-get update \
    && apt-get -y --no-install-recommends install git jq gnupg2 wget \
    && mkdir /app_build

WORKDIR /app_download

## Download gitea
RUN if [ -n "${app_version}" ] ; then export app_last_stable_release="${app_version}" ; else export app_last_stable_release=$(wget -O - https://api.github.com/repos/go-gitea/gitea/releases/latest | jq -r .tag_name | sed 's/^v//') ; fi \
    && if [ -z "${app_last_stable_release}" ] ; then echo "Error in file release identification, exit" >&2 ; exit 2 ; fi \
    && if [ "${TARGETARCH}" = "aarch64" ] ; then export build_arch="arm64" ; else export build_arch="${TARGETARCH}" ; fi \
    && echo "Will download version ${app_last_stable_release} for arch ${build_arch}" \
    && set -x \
    && wget -O gitea https://dl.gitea.io/gitea/${app_last_stable_release}/gitea-${app_last_stable_release}-linux-${build_arch} \
    && wget -O gitea.asc https://dl.gitea.io/gitea/${app_last_stable_release}/gitea-${app_last_stable_release}-linux-${build_arch}.asc \
    && git clone --depth 1 --branch v${app_last_stable_release} https://github.com/go-gitea/gitea.git gitea_src

## Verify package
RUN export gpg_key_fingerprint=7C9E68152594688862D62AF62D9AE806EC1592E2 \
    && gpg2 --keyserver  keys.openpgp.org --recv ${gpg_key_fingerprint} \
    && echo "${gpg_key_fingerprint}:6:" | gpg2 --import-ownertrust \
    && gpg2 --verify gitea.asc gitea
    
FROM quay.io/simbelmas/ubuntu:v2304.5@sha256:429439087cd58476727732292b15537a9ef802677eeb2c2ddf7830bef386984f

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN useradd -d /var/lib/gitea -u 1001 -s /usr/sbin/nologin svc \
    && apt-get update \
    && apt-get -y --no-install-recommends install git \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

COPY --from=Downloader /app_download/gitea /usr/local/bin/gitea
COPY --from=Downloader /app_download/gitea_src/options /usr/share/gitea/options
COPY --from=Downloader /app_download/gitea_src/public /usr/share/gitea/public
COPY --from=Downloader /app_download/gitea_src/templates /usr/share/gitea/templates
COPY app.ini /var/lib/gitea/custom/conf/app.ini

RUN mkdir -p /var/lib/gitea/custom /var/lib/gitea/data /var/lib/gitea/git /var/lib/gitea/log /usr/share/gitea /var/lib/gitea/custom/public/css \
    && chown -R svc:svc /var/lib/gitea \
    && chmod -R 750 /var/lib/gitea \ 
    && chmod a+x /usr/local/bin/gitea

WORKDIR /var/lib/gitea
USER 1001

ENTRYPOINT ["/usr/local/bin/gitea","web"]
CMD ["-c", "/var/lib/gitea/custom/conf/app.ini"]



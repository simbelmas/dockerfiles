#FROM docker.io/alpine:latest
FROM quay.io/fedora/fedora-minimal:latest
ARG arch=amd64
ARG arch_variant=""
ARG app_version
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'www-data:x:82:' >> /etc/group \
    && echo 'app:x:1001:82::/app:/sbin/nologin' >> /etc/passwd

RUN mkdir -p /app /app/data /etc/gotify \
    && chmod 750 /etc/gotify \
    && chown 1001:82 /etc/gotify \
    && microdnf -y install jq unzip wget \
    && export app_last_stable_release=$(curl -s https://api.github.com/repos/gotify/server/releases/latest | jq -r .tag_name) \
    && echo "Selected tag: ${app_last_stable_release}" \
    && cd /app \
    && if [ -n "${app_version}" ] ; then export app_last_stable_release="${app_version}" ; else export app_last_stable_release=$(curl -s https://api.github.com/repos/gotify/server/releases/latest | jq -r .tag_name) ; fi \
    && if [ "${arch}" = "aarch64" ] ; then export build_arch="arm64" ; else export build_arch="${arch}" ; fi \
    && echo "Will download version ${app_last_stable_release} for arch ${build_arch}" \
    && wget https://github.com/gotify/server/releases/download/${app_last_stable_release}/gotify-linux-${build_arch}.zip \
    && unzip gotify-linux-${build_arch}.zip \
    && mv gotify-linux-${build_arch} gotify \
    && rm gotify-linux-${build_arch}.zip \
    && chown 1001:82 /app -R \
    && chmod o-rwx /app -R \
    && chmod 750 gotify \
    && microdnf -y remove jq unzip wget \
    && microdnf clean all

RUN chown -Rv app:www-data /app \
    && chmod g+rwX /app -R \
    && chmod 750 /app

ENTRYPOINT ["/app/gotify"]

USER 1001
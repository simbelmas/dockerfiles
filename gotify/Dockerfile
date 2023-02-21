FROM quay.io/simbelmas/fedora-minimal:v37.11@sha256:6ae37cccca327d5c9529c8824b0d81a8e141aed331874827f116f10ca09e9938

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

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
    && if [ "${TARGETARCH}" = "aarch64" ] ; then export build_arch="arm64" ; else export build_arch="${TARGETARCH}" ; fi \
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

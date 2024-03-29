FROM quay.io/simbelmas/fedora-minimal:v38.15@sha256:24b8b6554efd5589eede507c66c008756aaee6653419e8173bf059f0c23af2ef AS Builder

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

## Install needed build tools
RUN dnf5 -y install jq unzip wget

WORKDIR /build

## Download Gotify
RUN export app_last_stable_release=$(wget -O - https://api.github.com/repos/gotify/server/releases/latest | jq -r .tag_name) \
    && echo "Selected tag: ${app_last_stable_release}" \
    && if [ -n "${app_version}" ] ; then export app_last_stable_release="${app_version}" ; else export app_last_stable_release=$(curl -s https://api.github.com/repos/gotify/server/releases/latest | jq -r .tag_name) ; fi \
    && if [ "${TARGETARCH}" = "aarch64" ] ; then export build_arch="arm64" ; else export build_arch="${TARGETARCH}" ; fi \
    && echo "Will download version ${app_last_stable_release} for arch ${build_arch}" \
    && wget https://github.com/gotify/server/releases/download/${app_last_stable_release}/gotify-linux-${build_arch}.zip \
     
## Build/install app
    &&unzip gotify-linux-${build_arch}.zip \
    && mv gotify-linux-${build_arch} gotify \
    && rm gotify-linux-${build_arch}.zip \
    && chmod 555 gotify

FROM quay.io/simbelmas/fedora-minimal:v38.15@sha256:24b8b6554efd5589eede507c66c008756aaee6653419e8173bf059f0c23af2ef

LABEL maintainer "Simon Belmas <slos@soket.fr>"

COPY --from=Builder /build/gotify /usr/local/bin

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app/data /etc/gotify \
    && chown -R app:app /etc/gotify /app

WORKDIR /app

USER 1001

ENTRYPOINT ["gotify"]
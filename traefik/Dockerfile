FROM quay.io/simbelmas/ubuntu:v2310.36@sha256:c22362e1f5ca299185d0a7e04007b607e8556a3ccbf54c70370e538be954aa73 AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apt-get update \
    && apt-get install -y wget
RUN mkdir /download \
    && cd /download \
    && export traefik_release=$(wget -q https://github.com/traefik/traefik/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && echo "latest traefik release is ${traefik_release} but use v2.11.2" \
    && export traefik_release="v2.11.2" \
    && echo tptf:${TARGETPLATFORM} tarc:${TARGETARCH} tvar:${TARGETVARIANT} \
    && if [ -n "$TARGETVARIANT" -a -n "$TARGETARCH" ] ; then dlarch=${TARGETARCH}${TARGETVARIANT} ; else dlarch=${TARGETARCH} ; fi  \
    && export download_url="https://github.com/traefik/traefik/releases/download/${traefik_release}/traefik_${traefik_release}_linux_${dlarch}.tar.gz" \
    && echo -n Download ; echo ${download_url} | tee software_downloaded_from \
    && wget -O app.tgz "${download_url}" \
    && tar -zxf app.tgz \
    && ls -al

FROM quay.io/simbelmas/ubuntu:v2310.36@sha256:c22362e1f5ca299185d0a7e04007b607e8556a3ccbf54c70370e538be954aa73

LABEL maintainer "Simon Belmas <slos@soket.fr>"

COPY --from=Downloader /download/traefik /usr/local/bin

USER 1001

ENTRYPOINT ["traefik"]
CMD []

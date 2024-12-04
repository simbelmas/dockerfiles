FROM quay.io/simbelmas/fedora-minimal:v41.8@sha256:e4d0f456c200168a78a40bc41078154452979e2cec9efa7b2096d78e8394647b AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN microdnf --nodocs --best -y install wget tar
RUN mkdir /download \
    && cd /download \
    && export traefik_release=$(wget -q https://github.com/traefik/traefik/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && echo "latest traefik release is ${traefik_release} but use v2.11.14" \
    && export traefik_release="v2.11.14" \
    && echo tptf:${TARGETPLATFORM} tarc:${TARGETARCH} tvar:${TARGETVARIANT} \
    && if [ -n "$TARGETVARIANT" -a -n "$TARGETARCH" ] ; then dlarch=${TARGETARCH}${TARGETVARIANT} ; else dlarch=${TARGETARCH} ; fi  \
    && export download_url="https://github.com/traefik/traefik/releases/download/${traefik_release}/traefik_${traefik_release}_linux_${dlarch}.tar.gz" \
    && echo -n Download ; echo ${download_url} | tee software_downloaded_from \
    && wget -O app.tgz "${download_url}" \
    && tar -zxf app.tgz \
    && ls -al

FROM quay.io/simbelmas/fedora-minimal:v41.8@sha256:e4d0f456c200168a78a40bc41078154452979e2cec9efa7b2096d78e8394647b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app

COPY --from=Downloader /download/traefik /usr/local/bin

USER 1001

ENTRYPOINT ["traefik"]
CMD []

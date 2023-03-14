FROM quay.io/simbelmas/alpine:latest@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache sqlite-libs gcompat bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib

RUN export arch=$(uname -m) \
    && echo Installing jackett on arch $arch \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export jackett_version="AMDx64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export jackett_version="ARM32" ; fi \
    && cd /opt \
    && wget -O - https://github.com/Jackett/Jackett/releases/download/v0.20.1907/Jackett.Binaries.LinuxMusl${jackett_version}.tar.gz | tar -zxf -

RUN addgroup -g 1001 jackett \
    && adduser -G jackett -D -h /opt/JackettData -u 1001 -s /bin/nologin jackett \
    && chown -Rv 1001:1001 /opt/Jackett /opt/JackettData

USER 1001
WORKDIR /opt/JackettData

ENV JACKETT_DIR=/opt/JackettData

ENTRYPOINT ["/opt/Jackett/jackett"]
CMD ["--NoRestart","--NoUpdates","--DataFolder","/opt/JackettData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

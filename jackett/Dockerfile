FROM quay.io/simbelmas/alpine:latest@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache sqlite-libs gcompat bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib

RUN export arch=$(uname -m) \
    && echo Installing jackett on arch $arch \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export jackett_arch="AMDx64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export jackett_arch="ARM32" ; fi \
    && cd /opt \
    && export jackett_release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && echo Downloading Jackett release ${jackett_release} for arch ${jackett_arch} \
    && wget -O - https://github.com/Jackett/Jackett/releases/download/${jackett_release}/Jackett.Binaries.LinuxMusl${jackett_arch}.tar.gz | tar -zxf -

RUN addgroup -g 1001 jackett \
    && adduser -G jackett -D -h /opt/JackettData -u 1001 -s /bin/nologin jackett \
    && chown -Rv 1001:1001 /opt/Jackett /opt/JackettData

USER 1001
WORKDIR /opt/JackettData

ENV JACKETT_DIR=/opt/JackettData

ENTRYPOINT ["/opt/Jackett/jackett"]
CMD ["--NoRestart","--NoUpdates","--DataFolder","/opt/JackettData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

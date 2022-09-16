ARG baseimg=docker.io/alpine:latest
FROM $baseimg

RUN apk add --no-cache sqlite-libs gcompat bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib

RUN export arch=$(uname -m) \
    && echo Installing jackett on arch $arch \
    && if [ "$arch" = "x86_64" ] ; then export jackett_version="AMDx64" ; elif [ "$arch" == "armv7l" ] ; then export jackett_version="ARM32" ; fi \
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

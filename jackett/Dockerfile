FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48 AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apt-get update \
    && apt-get -y install wget \
    && mkdir /build

WORKDIR /build

RUN export arch=$(uname -m) \
    && echo Installing jackett on arch $arch \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export jackett_arch="AMDx64" ; elif [ "${TARGETARCH}" = "arm" -a "${TARGETVARIANT}" = "v7" ] ; then export jackett_arch="ARM32" ; fi \
    && export jackett_release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && echo Downloading Jackett release ${jackett_release} for arch ${jackett_arch} \
    && wget -O - https://github.com/Jackett/Jackett/releases/download/${jackett_release}/Jackett.Binaries.Linux${jackett_arch}.tar.gz | tar -zxf -  \
    && chmod a+x Jackett/jackett

FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48

RUN apt-get update \
    && apt-get install -y libicu72 libssl3 \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

COPY --from=Downloader /build/Jackett /app

RUN mkdir /opt/JackettData \
    && groupadd -g 1001 app \
    && useradd -g app -d /opt/JackettData -u 1001 -s /usr/bin/nologin app \
    && chown -Rv 1001:1001 /opt/JackettData

ENV JACKETT_DIR=/opt/JackettData

WORKDIR /opt/JackettData
USER 1001

ENTRYPOINT ["/app/jackett"]
CMD ["--NoRestart","--NoUpdates","--DataFolder","/opt/JackettData"]


LABEL maintainer "Simon Belmas <slos@soket.fr>"

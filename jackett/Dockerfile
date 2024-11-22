FROM quay.io/simbelmas/fedora-minimal:v40.11@sha256:83e4f59cd8dc97fa4403a3ff3f9861ef0ecc35062ab25d12acec32c4017b7e55 AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN microdnf --nodocs -y install wget tar \
    && mkdir /build

WORKDIR /build

RUN export arch=$(uname -m) \
    && echo Installing jackett on arch $arch \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export jackett_arch="AMDx64" ; elif [ "${TARGETARCH}" = "arm" -a "${TARGETVARIANT}" = "v7" ] ; then export jackett_arch="ARM32" ; fi \
    && export jackett_release=$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && echo Downloading Jackett release ${jackett_release} for arch ${jackett_arch} \
    && wget -O - https://github.com/Jackett/Jackett/releases/download/${jackett_release}/Jackett.Binaries.Linux${jackett_arch}.tar.gz | tar -zxf -  \
    && chmod a+x Jackett/jackett

FROM quay.io/simbelmas/fedora-minimal:v40.11@sha256:83e4f59cd8dc97fa4403a3ff3f9861ef0ecc35062ab25d12acec32c4017b7e55

RUN microdnf --nodocs -y install libicu74 libssl3 \
    && microdnf clean all

COPY --from=Downloader /build/Jackett /app

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/opt/JackettData:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /opt/JackettData \
    && chmod -R 700 /opt/JackettData \ 
    && chown -R app:app /opt/JackettData

ENV JACKETT_DIR=/opt/JackettData

WORKDIR /opt/JackettData
USER 1001

ENTRYPOINT ["/app/jackett"]
CMD ["--NoRestart","--NoUpdates","--DataFolder","/opt/JackettData"]


LABEL maintainer "Simon Belmas <slos@soket.fr>"

FROM quay.io/simbelmas/alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache sqlite-libs gcompat bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib mediainfo sqlite chromaprint

RUN export arch=$(uname -m) \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export software_arch="x64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export software_arch="arm" ; fi \
    && cd /opt \
    && export download_url="http://lidarr.servarr.com/v1/update/master/updatefile?os=linuxmusl&runtime=netcore&arch=${software_arch}" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O - "${download_url}" | tar -zxf -

RUN apk add --no-cache curl

RUN adduser -G media -D -h /opt/mediaData -u 82 -s /bin/nologin -G www-data media \
    && chown -Rv media: /opt/Lidarr

USER 82
WORKDIR /opt/mediaData
ENTRYPOINT ["/opt/Lidarr/Lidarr"]
CMD ["-nobrowser","-data=/opt/mediaData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

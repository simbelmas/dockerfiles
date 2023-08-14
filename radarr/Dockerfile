FROM quay.io/simbelmas/ubuntu:v2310.11@sha256:f8288c377055e3b28d2dceb48c5104851c34c5a41c7b32fb8eaaa0dbb02457b9 AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apt-get update \
    && apt-get -y install curl sqlite3 wget \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN export arch=$(uname -m) \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export software_arch="x64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export software_arch="arm" ; fi \
    && cd /opt \
    && export download_url="http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=${software_arch}" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O - "${download_url}" | tar -zxf -
RUN chown 1001:1001 /opt/Radarr -R

FROM quay.io/simbelmas/ubuntu:v2310.11@sha256:f8288c377055e3b28d2dceb48c5104851c34c5a41c7b32fb8eaaa0dbb02457b9

COPY --from=Downloader /opt/Radarr /opt/Radarr

RUN apt-get update \
    && apt-get -y install sqlite3 libicu-dev \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \

USER 1001
WORKDIR /opt/mediaData
ENTRYPOINT ["/opt/Radarr/Radarr"]
CMD ["-nobrowser","-data=/opt/mediaData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48 AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN apt-get update \
    && apt-get -y install sqlite3 wget

RUN export arch=$(uname -m) \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export software_arch="x64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export software_arch="arm" ; fi \
    && cd /opt \
    && export download_url="http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=${software_arch}" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O - "${download_url}" | tar -zxf -
RUN chown 1001:1001 /opt/Radarr -R

FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48

COPY --from=Downloader /opt/Radarr /opt/Radarr

RUN apt-get update \
    && apt-get -y install sqlite3 libicu-dev \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/opt/mediaData:/sbin/nologin' >> /etc/passwd \
    && mkdir /opt/mediaData \
    && chown 1001:1001 /opt/mediaData

USER 1001
WORKDIR /opt/mediaData
ENTRYPOINT ["/opt/Radarr/Radarr"]
CMD ["-nobrowser","-data=/opt/mediaData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

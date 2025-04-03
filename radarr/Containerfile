FROM quay.io/simbelmas/fedora-minimal:v41.39@sha256:1a20a13a0cb98d61e8ef3c2e38f80ae80312d1956a06851fd03deb0e28844e8c AS Downloader

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN microdnf --nodocs --best -y install sqlite3 wget tar

RUN export arch=$(uname -m) \
    && if [ "${TARGETARCH}" = "amd64" ] ; then export software_arch="x64" ; elif [ "${TARGETARCH}" == "arm" -a "${TARGETVARIANT}" == "v7" ] ; then export software_arch="arm" ; fi \
    && cd /opt \
    && export download_url="http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=${software_arch}" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O - "${download_url}" | tar -zxf -
RUN chown 1001:1001 /opt/Radarr -R

FROM quay.io/simbelmas/fedora-minimal:v41.39@sha256:1a20a13a0cb98d61e8ef3c2e38f80ae80312d1956a06851fd03deb0e28844e8c

COPY --from=Downloader /opt/Radarr /opt/Radarr

RUN microdnf --nodocs --best -y install sqlite3 libicu-devel \
    && microdnf clean all

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/opt/mediaData:/sbin/nologin' >> /etc/passwd \
    && mkdir /opt/mediaData \
    && chown 1001:1001 /opt/mediaData

USER 1001
WORKDIR /opt/mediaData
ENTRYPOINT ["/opt/Radarr/Radarr"]
CMD ["-nobrowser","-data=/opt/mediaData"]


LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/fedora-minimal:v41.2@sha256:7b0aa7c0c74aebdbeaeebbf4e8d6bdfe962fc9bc4b97927149ff211191cd11ad AS Downloader

RUN microdnf -y --nodocs install unzip wget2-wget \
    && mkdir /opt/rdtclient \
    && cd /opt/rdtclient \
    && export rdtclient_release=$(wget -q https://github.com/rogerfar/rdt-client/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && export download_url="https://github.com/rogerfar/rdt-client/releases/download/${rdtclient_release}/RealDebridClient.zip" \
    && wget -O ../rdtclient.zip "${download_url}" \
    && unzip ../rdtclient.zip

COPY appsettings.json /opt/rdtclient/
RUN chown 1001:1001 -R /opt/rdtclient

FROM quay.io/simbelmas/fedora-minimal:v41.2@sha256:7b0aa7c0c74aebdbeaeebbf4e8d6bdfe962fc9bc4b97927149ff211191cd11ad

RUN microdnf -y --nodocs install dotnet-sdk-9.0 \
    && microdnf clean all

COPY --from=Downloader /opt/rdtclient /opt/rdtclient
COPY entrypoint.sh /opt/rdtclient/entrypoint.sh

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/opt/mediaData:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /opt/mediaData/db \
    && chmod a+rx /opt/rdtclient/entrypoint.sh \
    && chown 1001:1001 -R /opt/mediaData

USER 1001
WORKDIR /opt/rdtclient
ENTRYPOINT ["/opt/rdtclient/entrypoint.sh"]

LABEL maintainer "Simon Belmas <slos@soket.fr>"

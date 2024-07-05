FROM quay.io/simbelmas/ubuntu:v2310.42@sha256:1f06915ad147febfc3e4713cca42fabd76872f9f2273600655f975e4f34dd372 AS Downloader



RUN apt-get update \
    && apt-get -y install unzip wget \
    && mkdir /opt/rdtclient \
    && cd /opt/rdtclient \
    && export rdtclient_release=$(wget -q https://github.com/rogerfar/rdt-client/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && export download_url="https://github.com/rogerfar/rdt-client/releases/download/${rdtclient_release}/RealDebridClient.zip" \
    && wget -O ../rdtclient.zip "${download_url}" \
    && unzip ../rdtclient.zip

COPY appsettings.json /opt/rdtclient/
RUN chown 1001:1001 -R /opt/rdtclient

FROM quay.io/simbelmas/ubuntu:v2310.42@sha256:1f06915ad147febfc3e4713cca42fabd76872f9f2273600655f975e4f34dd372

RUN apt-get update \
    && apt-get -y install dotnet8 \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

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

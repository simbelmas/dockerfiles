FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48 AS Downloader



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

FROM quay.io/simbelmas/ubuntu:v2310.15@sha256:01368fee5360181cf5eee8f6ced2e5c87d7b4eb1e88cc3258cd2c89fbbf9ac48

RUN apt-get update \
    && apt-get -y install dotnet8 \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

COPY --from=Downloader /opt/rdtclient /opt/rdtclient

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/opt/mediaData:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /opt/mediaData/db \
    && chown 1001:1001 -R /opt/mediaData

USER 1001
WORKDIR /opt/rdtclient
ENTRYPOINT ["dotnet", "/opt/rdtclient/RdtClient.Web.dll"]

LABEL maintainer "Simon Belmas <slos@soket.fr>"

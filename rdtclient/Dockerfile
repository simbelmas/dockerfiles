FROM quay.io/simbelmas/alpine:latest@sha256:b95359c2505145f16c6aa384f9cc74eeff78eb36d308ca4fd902eeeb0a0b161b

RUN apk add --no-cache dotnet6-sdk

RUN apk --no-cache -t dev_tools add unzip \
    && cd /opt \
    && export download_url="https://github.com/rogerfar/rdt-client/releases/download/v2.0.17/RealDebridClient.zip" \
    && echo ${download_url} > software_downloaded_from \
    && wget -O rdtclient.zip "${download_url}" \
    && mkdir rdtclient \
    && cd rdtclient \
    && unzip ../rdtclient.zip \
    && rm ../rdtclient.zip \
    && apk del dev_tools

COPY appsettings.json /opt/rdtclient/

RUN adduser -G media -D -h /opt/mediaData -u 82 -s /bin/nologin -G www-data media \
    && mkdir /opt/mediaData/db \
    && chown -Rv media: /opt/rdtclient /opt/mediaData

USER 82
WORKDIR /opt/rdtclient
ENTRYPOINT ["dotnet", "/opt/rdtclient/RdtClient.Web.dll"]

LABEL maintainer "Simon Belmas <slos@soket.fr"

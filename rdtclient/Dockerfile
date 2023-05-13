FROM quay.io/simbelmas/alpine:latest@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

RUN apk add --no-cache dotnet6-sdk

RUN apk --no-cache -t dev_tools add unzip \
    && cd /opt \
    && export rdtclient_release=$(wget -q https://github.com/rogerfar/rdt-client/releases/latest -O - | grep "title>Release" | cut -d " " -f 4) \
    && export download_url="https://github.com/rogerfar/rdt-client/releases/download/${rdtclient_release}/RealDebridClient.zip" \
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

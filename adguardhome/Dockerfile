FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:fc01fa555e6b324378176dff676c7791b2bb6ebfcf63bd2599db568287de7230

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

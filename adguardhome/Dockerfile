FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:a967df987abb6444d9e1ea8871f6b91c69e37f7908496e11cb69229426512fe7

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

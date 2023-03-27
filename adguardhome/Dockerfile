FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:a9365a096f019ba37a170c3c643f0cb8598e47e9144d568e201eb5c7de4a9d83

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

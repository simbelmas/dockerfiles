FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:ce8b9ae82365edcd4c91d0a3763091fac6a9541a1ef36d9b65274078517745b2

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

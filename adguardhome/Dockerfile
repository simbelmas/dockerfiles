FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:4016a420451810959f782d3cbe04c620d83c3431cbb13ae27aabd2921db482a0

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

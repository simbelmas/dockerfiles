FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:60484ed297f5e58695969ef3cc20208d9e4e631394aafd05ac39c0e68fd7d944

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

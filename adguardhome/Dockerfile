FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:d9c512051141e6a617d773f16cdf6782c178464c6e766acf9fe63482a171f95c

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:5c536c1e25f76693ae7ee5e64e8a029893e0f3f1778c8d2a9581383e60cfa9b9

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

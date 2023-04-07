FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:09c491f2bbd5d175d671f34ef485283ddc1c8c08435d652ae583b7be3d941be0

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

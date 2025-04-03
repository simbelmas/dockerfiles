FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:5d5e3aef39a8c8906a324f0c2da0a6123929e459b57c1e3f05e401dca5c7bf02

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

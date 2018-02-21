FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:c2f8087661065cb7958539f9edcb44c05f8fcc6db4880f53c16f0e6f8b63f33d

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

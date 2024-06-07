FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:3a143e6c071cd72b1aa5aa46ba0205a86f085d54daca94b7fc7ab6759e3fb6fa

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:5cc027e0b5b96b5006eaeffa9fe68d601595321090c3b8af37b61105ddbbaac1

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

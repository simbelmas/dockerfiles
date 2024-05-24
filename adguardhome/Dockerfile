FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:f890b77505e410e295cc96830632b46075d7263cef52c158f9331348c98e1228

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

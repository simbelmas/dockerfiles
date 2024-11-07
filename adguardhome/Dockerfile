FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:ec59d9d8d083b74620f827879bee7ad88621f96bc0c4347c84c176ffa349484c

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:b9f635f51cec62205dd7bcae0d9bfffe3a33a6d30f3787d9fb7eb531281532d2

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

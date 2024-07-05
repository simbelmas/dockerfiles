FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:d16cc7517ab96f843e7f8bf8826402dba98f5e6b175858920296243332391589

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

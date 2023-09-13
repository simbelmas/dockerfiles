FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:43ec119419a91537de0698c9b762c38fc548541ae5a67573eff551fd346e0525

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

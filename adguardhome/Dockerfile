FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:5d418f5b949cbdc08841bbfc2e70ec4903e3b8e394da010e02b3bf1ca6711219

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:4483861963bd1aeb3e6661e4da5b14402c659b43d207cf59fa0962d75ce496cb

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

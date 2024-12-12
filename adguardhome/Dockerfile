FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:2979cc78a28aceb77f90980a5440578dbb7bc406dffe261e9ae402750193bde0

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

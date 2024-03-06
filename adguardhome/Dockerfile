FROM quay.io/simbelmas/adguardhome:dockerio-latest-mirror@sha256:049ef6c019a629b33db2ef957665b257fbd5761970a1517a309807fb128befb1

RUN addgroup -g 1001 adguard \
    && adduser -G adguard -D -H -h /opt/adguardhome -u 1001 -s /bin/nologin adguard \
    && chown -Rv 1001:1001 /opt/adguardhome

USER 1001

LABEL maintainer "Simon Belmas <slos@soket.fr"

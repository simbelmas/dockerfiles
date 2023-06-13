FROM quay.io/simbelmas/ubuntu:v2304.5@sha256:429439087cd58476727732292b15537a9ef802677eeb2c2ddf7830bef386984f

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN RUN apt-get update \
    && apt-get install -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

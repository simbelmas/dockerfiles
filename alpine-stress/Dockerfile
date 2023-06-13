FROM quay.io/simbelmas/ubuntu:v2304.6@sha256:94a84c597cd7c41036e745aa22ef8b6cfd4539f95e4d2e07508444782287c94e

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN RUN apt-get update \
    && apt-get install -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

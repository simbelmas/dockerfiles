FROM quay.io/simbelmas/ubuntu:v2304.2@sha256:1ca5e9009caab5c0a1fcc2ed4d90e58585ca79517eef5a747b1b88d79a873ba4

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN RUN apt-get update \
    && apt-get install -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

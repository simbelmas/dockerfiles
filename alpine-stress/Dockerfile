FROM quay.io/simbelmas/ubuntu:v2310.3@sha256:953b0a5a90cee8650783c8d771009559dec1522c00b3a40e612799fa887e6210

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN RUN apt-get update \
    && apt-get install -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

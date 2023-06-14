FROM quay.io/simbelmas/ubuntu:v2310.2@sha256:ea834b1292187d2e08a90c6135881df9d60e9ce0ebe732c87695adc6dc974563

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN RUN apt-get update \
    && apt-get install -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

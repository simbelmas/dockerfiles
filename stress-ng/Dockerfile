FROM quay.io/simbelmas/ubuntu:v2310.46@sha256:a9dba9312d5182ce65f61a100e566705e0b7ff460acbfcc14617f08cbe411c64

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd --gid 1001 svc \
    && useradd --gid svc --home-dir /app -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

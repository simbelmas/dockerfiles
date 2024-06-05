FROM quay.io/simbelmas/ubuntu:v2310.39@sha256:5eef25e3e87365bc0bf7c946b9ae1600b67e175ba87d174c4f8193f30f0b8c9e

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd --gid 1001 svc \
    && useradd --gid svc --home-dir /app -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

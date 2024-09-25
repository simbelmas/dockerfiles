FROM quay.io/simbelmas/ubuntu:v2310.55@sha256:17f7eed59e7d8037fdb5bf3fd7d0dfb79a6e69ee06970ab797cdfba04850daef

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd --gid 1001 svc \
    && useradd --gid svc --home-dir /app -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

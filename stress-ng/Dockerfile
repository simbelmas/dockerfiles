FROM quay.io/simbelmas/ubuntu:v2310.60@sha256:93659a02c2d604cedf927045299be04a4ecdc7f19c8038410937ce934e02faec

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get install --no-install-recommends -y stress-ng \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd --gid 1001 svc \
    && useradd --gid svc --home-dir /app -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

FROM quay.io/simbelmas/ubuntu:v2310.11@sha256:2a83fb0f9e7748c4f02c224c1f3fa996a9edddab3db64c28b72db3bcddee4b26

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


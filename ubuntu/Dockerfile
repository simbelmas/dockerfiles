FROM quay.io/simbelmas/ubuntu:dockerio-23.10-mirror

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


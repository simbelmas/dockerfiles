FROM quay.io/simbelmas/ubuntu:dockerio-23.10-mirror@sha256:f38f426535f7af96f85b908b00bfc9c1326c46184e318b1d720923a719ce38dd

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


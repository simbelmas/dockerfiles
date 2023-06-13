FROM quay.io/simbelmas/ubuntu:dockerio-23.04-mirror@sha256:fe0a6611c5a3d0fbfd42f4e5a95338c12273ab435c99d36eca3ef71be2cbc135

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


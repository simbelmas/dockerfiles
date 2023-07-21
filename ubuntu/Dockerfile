FROM quay.io/simbelmas/ubuntu:v2310.11@sha256:f8288c377055e3b28d2dceb48c5104851c34c5a41c7b32fb8eaaa0dbb02457b9

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


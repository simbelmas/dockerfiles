FROM quay.io/simbelmas/ubuntu:dockerio-23.10-mirror@sha256:beb04006b159c829375d3cede2fc1a5e1c271ce19993d2de05aabede7e6f220d

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


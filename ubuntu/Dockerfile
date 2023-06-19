FROM quay.io/simbelmas/ubuntu:dockerio-23.10-mirror@sha256:71f0dc1af45663d790562e36cbb6c448a3826c77ce1ecbe726b523c8c623d58b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*


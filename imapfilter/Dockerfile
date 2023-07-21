
FROM quay.io/simbelmas/ubuntu:v2310.11@sha256:f8288c377055e3b28d2dceb48c5104851c34c5a41c7b32fb8eaaa0dbb02457b9

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get --no-install-recommends -y install imapfilter\
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd -g 1001 app \
    && useradd -g app -d /app -u 1001 -s /usr/bin/nologin app \
    && mkdir -vp /app/creds /app/config \
    && chown -Rv 1001:1001 /app

COPY --chown=1001:1001 run.lua /app/run.lua

USER 1001

ENTRYPOINT ["imapfilter", "-c", "/app/run.lua"]
CMD []

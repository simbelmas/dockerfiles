
FROM quay.io/simbelmas/ubuntu:v2310.22@sha256:7a4d8c7867a156f82ad5d1181e29ee541f3beadf615c7809aa44da85dfd3e77a

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

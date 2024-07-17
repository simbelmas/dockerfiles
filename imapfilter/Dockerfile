
FROM quay.io/simbelmas/ubuntu:v2310.45@sha256:f99cf52434d6a2a8d627802724e591ea666762edff17ee1ede8abc768b08063b

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

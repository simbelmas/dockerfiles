
FROM quay.io/simbelmas/ubuntu:v2310.42@sha256:1f06915ad147febfc3e4713cca42fabd76872f9f2273600655f975e4f34dd372

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

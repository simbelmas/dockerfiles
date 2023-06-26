
FROM quay.io/simbelmas/ubuntu:v2310.5@sha256:8f7045911914e770fd689cf300fbda59152c3a4e33cc6f070d74c35fe118ae34

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

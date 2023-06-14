
FROM quay.io/simbelmas/ubuntu:v2310.3@sha256:953b0a5a90cee8650783c8d771009559dec1522c00b3a40e612799fa887e6210

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get --no-install-recommends -y install imapfilter\
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/*

RUN groupadd -g 1001 imapfilter \
    && useradd -G imapfilter -d /imapfilter -u 1001 -s /bin/nologin imapfilter \
    && mkdir -vp /imapfilter/creds /imapfilter/config \
    && chown -Rv 1001:1001 /imapfilter

COPY --chown=1001:1001 run.lua /imapfilter/run.lua

USER 1001

ENTRYPOINT ["imapfilter", "-c", "/imapfilter/run.lua"]
CMD []

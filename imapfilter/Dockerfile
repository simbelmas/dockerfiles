FROM quay.io/simbelmas/alpine:latest@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a

LABEL maintainer "Simon Belmas <slos@soket.fr>"
#Compile imapfilter
RUN apk --no-cache add lua openssl pcre2\
    && apk --no-cache  add -t dev_tools git lua-dev openssl-dev make gcc libc-dev pcre2-dev \
    && git clone https://github.com/lefcha/imapfilter.git /imapfilter_build \
    && cd /imapfilter_build \
    && make \
    && make install \
    && rm -rf /imapfilter_build \
    && apk del dev_tools

RUN addgroup -g 1001 imapfilter \
    && adduser -G imapfilter -D -H -h /imapfilter -u 1001 -s /bin/nologin imapfilter \
    && mkdir -vp /imapfilter/creds /imapfilter/config \
    && chown -Rv 1001:1001 /imapfilter

COPY --chown=1001:1001 run.lua /imapfilter/run.lua

USER 1001

ENTRYPOINT ["/usr/local/bin/imapfilter", "-c", "/imapfilter/run.lua"]
CMD []

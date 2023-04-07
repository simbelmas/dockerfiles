FROM quay.io/simbelmas/alpine:latest@sha256:124c7d2707904eea7431fffe91522a01e5a861a624ee31d03372cc1d138a3126

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

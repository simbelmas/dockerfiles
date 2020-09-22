ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"
#Compile imapfilter
RUN apk --no-cache add mosquitto

RUN addgroup -g 1001 mosquittorun \
    && adduser -G mosquittorun -D -H -h /mosquitto -u 1001 -s /bin/nologin mosquittorun \
    && mkdir -vp /mosquitto \
    && chown -Rv 1001:1001 /mosquitto


USER 1001

ENTRYPOINT ["/usr/sbin/mosquitto"]
CMD ["--help"]

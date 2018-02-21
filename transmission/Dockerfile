ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr"
#Compile imapfilter
RUN apk --no-cache add transmission-daemon


RUN addgroup -g 1001 svcgrp \
    && adduser -G svcgrp -D -H -h /config -u 1001 -s /bin/nologin svcusr \
    && mkdir -vp /config /downloads/{complete,incomplete} \
    && chown -Rv 1001:1001 /config /downloads
USER 1001

ENTRYPOINT ["/usr/bin/transmission-daemon"]
CMD ["--foreground", "--no-watch-dir", "--incomplete-dir","/downloads/incomplete", "--config-dir", "/config", "--logfile", "/dev/stdout", "--download-dir", "/downloads/complete","--log-error", "--log-info", "--pid-file", "/tmp/transmission.pid", "--allowed", "*.*.*.*" ]

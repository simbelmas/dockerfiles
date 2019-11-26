FROM docker.io/alpine

LABEL maintainer "Simon Belmas <slos@soket.fr"
#Compile imapfilter
RUN apk --no-cache add transmission-daemon

RUN mkdir -vp /config /downloads/{complete,incomplete} \
    && chown -vR transmission: /config /downloads 

USER 100

ENTRYPOINT ["/usr/bin/transmission-daemon"]
CMD ["--foreground", "--no-watch-dir", "--incomplete-dir","/downloads/incomplete", "--config-dir", "/config", "--logfile", "/dev/stdout", "--download-dir", "/downloads/complete","--log-error", "--pid-file", "/tmp/transmission.pid" ]

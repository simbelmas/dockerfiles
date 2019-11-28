FROM docker.io/alpine

LABEL maintainer "Simon Belmas <slos@soket.fr"
#Compile imapfilter
RUN apk --no-cache add transmission-daemon

RUN mkdir -vp /transmission_settings /config /downloads/{complete,incomplete} \
    && ln -sf /transmission_settings/settings.json /config/settings.json \
    && chown -vR transmission: /config /downloads /transmission_settings

USER 100

ENTRYPOINT ["/usr/bin/transmission-daemon"]
CMD ["--foreground", "--no-watch-dir", "--incomplete-dir","/downloads/incomplete", "--config-dir", "/config", "--logfile", "/dev/stdout", "--download-dir", "/downloads/complete","--log-error", "--pid-file", "/tmp/transmission.pid" ]

FROM docker.io/alpine

LABEL maintainer "Simon Belmas <slos@soket.fr"
#Compile imapfilter
RUN apk --no-cache add transmission-daemon

RUN mkdir -vp /transmission_settings /config /downloads/{complete,incomplete} \
    && ln -sf /transmission_settings/settings.json /config/settings.json \
    && chown -vR 100:101 /config /downloads /transmission_settings

COPY run.sh /run.sh
RUN chmod a+rx /run.sh

USER 100


#ENTRYPOINT ["/usr/bin/transmission-daemon"]
#CMD ["--foreground", "--no-watch-dir", "--incomplete-dir","/downloads/incomplete", "--config-dir", "/config", "--logfile", "/dev/stdout", "--download-dir", "/downloads/complete","--log-error", "--log-info", "--pid-file", "/tmp/transmission.pid"
ENTRYPOINT ["/run.sh" ]

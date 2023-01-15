FROM quay.io/simbelmas/alpine:latest

LABEL maintainer "Simon Belmas <slos@soket.fr>"


RUN addgroup -g 1001 app \
    && adduser -G app -D  -h /app -u 1001 -s /bin/sh app

USER 1001

ENTRYPOINT ["/bin/sh"]
CMD []

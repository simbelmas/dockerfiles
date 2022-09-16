FROM quay.io/simbelmas/php-fpm-alpine:latest

LABEL maintainer "Simon Belmas <slos@soket.fr>"

USER 0

RUN apk --no-cache add youtube-dl aria2
 
USER 82

EXPOSE 9000

CMD ["start_fpm"]

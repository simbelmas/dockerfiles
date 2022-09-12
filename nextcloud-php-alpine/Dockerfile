ARG baseimg=quay.io/simbelmas/php-fpm-alpine:amd64
FROM $baseimg

USER 0

LABEL maintainer "Simon Belmas <slos@soket.fr>"
RUN apk --no-cache add youtube-dl aria2
 
USER 82

EXPOSE 9000

CMD ["start_fpm"]

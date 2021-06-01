ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"
#Compile imapfilter
RUN apk --no-cache add gitea

RUN deluser gitea \
    && adduser -G www-data -D -H -h /var/lib/gitea -u 1001 gitea \
    && chown -Rv gitea:www-data /var/lib/gitea \
    && chmod o-rwx /etc/gitea -R \
    && chmod g+rX /etc/gitea -R \
    && chmod -v 755 /usr/bin/gitea


USER 1001

CMD ["/usr/bin/gitea","web","--config","/etc/gitea/app.ini"]
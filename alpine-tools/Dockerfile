ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       borgbackup \
       nfs-utils \
       vimdiff \
       git less openssh curl \
    && apk --no-cache add  python3 py3-pip \
    && pip3 install kubernetes jinja2-tools
   
RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data
USER 1001

CMD ["git", "--help"]

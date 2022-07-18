ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       nfs-utils \
       git less openssh curl \
       rsync \
       python3 py3-pip \
       openssl libacl libattr \
    && apk --no-cache  add -t dev_tools openssl-dev make gcc libc-dev pkgconf python3-dev acl-dev attr-dev linux-headers \
    && pip3 install --upgrade pip setuptools wheel \
    && pip3 install kubernetes jinja2-tools \
    && pip3 install pkgconfig \
    && pip3 install borgbackup \
    && pip3 uninstall -y pkgconfig \
    && apk del dev_tools

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data

USER 1001

CMD ["git", "--help"]

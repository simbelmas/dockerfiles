FROM quay.io/simbelmas/alpine:latest@sha256:82d1e9d7ed48a7523bdebc18cf6290bdb97b82302a8a9c27d4fe885949ea94d1

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       nfs-utils \
       git less openssh curl \
       rsync \
       python3 py3-pip \
       openssl libacl libattr \
       borgbackup \
    && apk --no-cache  add -t dev_tools openssl-dev make gcc libc-dev pkgconf python3-dev acl-dev attr-dev linux-headers \
    && pip3 install --upgrade pip setuptools wheel \
    && pip3 install kubernetes jinja2-tools \
    && pip3 install pkgconfig \
    && pip3 uninstall -y pkgconfig \
    && apk del dev_tools
#    && pip3 install borgbackup \

RUN addgroup -g 1001 svc \
    && adduser -G svc -D -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data

USER 1001

CMD ["git", "--help"]

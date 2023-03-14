FROM quay.io/simbelmas/alpine:latest@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517

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
    && adduser -G svc -D -u 1001 -s /bin/nologin svc \
    && adduser -G www-data -D -u 82 -s /sbin/nologin www-data

USER 1001

CMD ["git", "--help"]

ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add git less openssh

VOLUME /git
WORKDIR /git

RUN addgroup -g 1001 git \
    && adduser -G git -D -H -u 1001 -s /bin/nologin git

USER 1001

ENTRYPOINT ["git"]
CMD ["--help"]

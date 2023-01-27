FROM quay.io/simbelmas/alpine:latest@sha256:f271e74b17ced29b915d351685fd4644785c6d1559dd1f2d4189a5e851ef753a
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       stress-ng stress-ng-doc
   
RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

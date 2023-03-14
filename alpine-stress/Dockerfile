FROM quay.io/simbelmas/alpine:latest@sha256:ff6bdca1701f3a8a67e328815ff2346b0e4067d32ec36b7992c1fdc001dc8517
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       stress-ng stress-ng-doc
   
RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

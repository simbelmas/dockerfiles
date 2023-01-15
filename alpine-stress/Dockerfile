FROM quay.io/simbelmas/alpine:latest
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add \
       stress-ng stress-ng-doc
   
RUN addgroup -g 1001 svc \
    && adduser -G svc -D -H -u 1001 -s /bin/nologin svc

WORKDIR /tmp 

USER 1001

CMD ["stress-ng", "--help"]

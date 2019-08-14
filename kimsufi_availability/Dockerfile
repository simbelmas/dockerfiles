FROM alpine:latest

RUN apk --no-cache add curl jq email \
    && adduser -D kim \
    && mkdir /kim

COPY check.sh /kim/check.sh
COPY README.md /kim/README.md

RUN chown -R kim: /kim \
    && chmod u+x /kim/check.sh

USER kim

WORKDIR /kim

ENTRYPOINT [ "./check.sh" ]

FROM alpine:latest

RUN apk --no-cache add texlive-full

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

FROM quay.io/simbelmas/alpine:latest@sha256:69665d02cb32192e52e07644d76bc6f25abeb5410edc1c7a81a10ba3f0efb90a

RUN apk --no-cache add fontconfig && \
      apk --no-cache add ttf-freefont ttf-dejavu ttf-linux-libertine ttf-opensans  ttf-cantarell ttf-liberation msttcorefonts-installer && \
      update-ms-fonts
RUN apk --no-cache add texlive-full 

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

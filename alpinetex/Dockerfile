FROM quay.io/simbelmas/alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

RUN apk --no-cache add fontconfig && \
      apk --no-cache add ttf-freefont ttf-dejavu ttf-linux-libertine ttf-opensans  ttf-cantarell ttf-liberation msttcorefonts-installer && \
      update-ms-fonts
RUN apk --no-cache add texlive-full 

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

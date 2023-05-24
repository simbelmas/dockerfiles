FROM quay.io/simbelmas/alpine:latest@sha256:02bb6f428431fbc2809c5d1b41eab5a68350194fb508869a33cb1af4444c9b11

RUN apk --no-cache add fontconfig && \
      apk --no-cache add ttf-freefont ttf-dejavu ttf-linux-libertine ttf-opensans  ttf-cantarell ttf-liberation msttcorefonts-installer && \
      update-ms-fonts
RUN apk --no-cache add texlive-full 

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

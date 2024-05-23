FROM quay.io/simbelmas/alpine:latest@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

RUN apk --no-cache add fontconfig && \
      apk --no-cache add ttf-freefont ttf-dejavu ttf-linux-libertine ttf-opensans  ttf-cantarell ttf-liberation msttcorefonts-installer && \
      update-ms-fonts
RUN apk --no-cache add texlive-full 

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

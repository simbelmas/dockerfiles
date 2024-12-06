FROM quay.io/simbelmas/alpine:latest@sha256:21dc6063fd678b478f57c0e13f47560d0ea4eeba26dfc947b2a4f81f686b9f45

RUN apk --no-cache add fontconfig && \
      apk --no-cache add ttf-freefont ttf-dejavu ttf-linux-libertine ttf-opensans  ttf-cantarell ttf-liberation msttcorefonts-installer && \
      update-ms-fonts
RUN apk --no-cache add texlive-full 

RUN mkdir /build
WORKDIR /build
CMD /bin/ash -c 'for source in *.tex; do echo "Building ${source}"; xelatex ${source}; done'

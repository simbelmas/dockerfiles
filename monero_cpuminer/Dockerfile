FROM alpine

#Install requirements
RUN apk --no-cache add \
      libcurl \
      libgcc \
      libstdc++ \
      libressl  \
      dumb-init

#Install dev tools
RUN apk --no-cache  add -t dev_tools \
      autoconf \
      automake \
      build-base \
      curl-dev \
      libressl-dev \
      libc-dev \
      git

#Grab source and compile it
RUN git clone https://github.com/hyc/cpuminer-multi /cpuminer-multi \
  && cd //cpuminer-multi \
  && ./autogen.sh \
  && ./configure CFLAGS="-march=native" --with-crypto --with-curl \
  && make install

##Cleanup
RUN apk del --purge dev_tools

ENTRYPOINT ["dumb-init","--"]
CMD ["minerd","--help"]

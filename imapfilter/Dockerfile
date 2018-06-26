FROM alpine

#Install requirements
RUN apk --no-cache add lua openssl pcre

#Install dev tools to compile imapfilter
RUN apk --no-cache  add git -t dev_tools lua-dev openssl-dev make gcc libc-dev pcre-dev

#Compile imapfilter and install it
RUN git clone https://github.com/lefcha/imapfilter.git /imapfilter_build
RUN cd /imapfilter_build \
  && make \
  && make install

#Cleanup
RUN rm -rf /imapfilter_build
RUN apk del dev_tools

#Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT /run.sh

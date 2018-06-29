FROM alpine

RUN apk --no-cache add python3 xmlsec

#Install dev tools
RUN apk --no-cache  add -t dev_tools  make gcc libc-dev python3-dev xmlsec-dev
RUN pip3 --no-cache install caldav icalendar requests
RUN apk --no-cache del dev_tools

#Install scripts
RUN mkdir /wificontrol
COPY *.py /wificontrol/
COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh","python3","/wificontrol/manage_wifi.py"]

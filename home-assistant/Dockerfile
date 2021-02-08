ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add python3 py3-pip libjpeg libtiffxx 
RUN apk --no-cache add -t dev_tools make gcc g++ autoconf \
      python3-dev openssl-dev zlib-dev libffi-dev \
      linux-headers musl-dev git libxml2-dev libxslt-dev jpeg-dev \
    && git clone --depth 1 https://github.com/home-assistant/core.git /tmp/hass_src \
    && cd /tmp/hass_src \
    && pip3 install wheel \
    && pip3 install mutagen gtts pyMetno homeassistant \
    && pip3 install -r requirements.txt \
    && sed '/1000000000.0.0/d' -i homeassistant/package_constraints.txt \
    && pip3 install -r homeassistant/package_constraints.txt \
    && rm -rf /tmp/hass_src \
    && rm -rf /root/.cache/* \
    && apk del dev_tools

RUN addgroup -g 1001 hass \
    && adduser -G hass -D -H -h /hass -u 1001 -s /bin/nologin hass \
    && adduser hass dialout \
    && mkdir -vp /hass/creds /hass/config \
    && chown -Rv 1001:1001 /hass

USER 1001

ENTRYPOINT ["/usr/bin/hass", "-c", "/hass", "--runner", "--skip-pip", "--debug"]
CMD []

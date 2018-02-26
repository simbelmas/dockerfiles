FROM simbelmas/fedora-pulse
RUN dnf -y install wget \
    && export latest_tag=$(curl https://github.com/saenzramiro/rambox/releases/latest 2>/dev/null | sed -n -E 's#^.*tag/(.*)">red.*$#\1#p') \
    && export rpm_url=https://github.com/saenzramiro/rambox/releases/download/${latest_tag}/Rambox-${latest_tag}-x64.rpm \
    && wget -O rambox_latest.rpm ${rpm_url}

RUN dnf -y install rambox_latest.rpm \
    && dnf -y install libXScrnSaver \
    && dnf -y install GConf2

RUN dnf -y remove wget \
    && rm rambox_latest.rpm \
    && dnf clean all

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT /run.sh

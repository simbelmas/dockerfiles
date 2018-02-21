FROM simbelmas/fedora-pulse
RUN dnf -y install thunderbird thunderbird-enigmail \
    && dnf clean all

COPY run.sh /run.sh
RUN chmod a+x /run.sh \
    && chown svc: /home/svc/ -R

ENV HOME /home/svc
USER svc

ENTRYPOINT /run.sh

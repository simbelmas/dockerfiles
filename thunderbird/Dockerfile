FROM simbelmas/fedora-pulse
RUN dnf -y install thunderbird thunderbird-enigmail \
    && dnf clean all

RUN useradd -m svc \
  && usermod -a -G audio,video svc

COPY run.sh /run.sh
COPY pulse-client.conf /home/svc/.config/pulse/client.conf
RUN chmod a+x /run.sh \
    && chown svc: /home/svc/ -R

ENV HOME /home/svc
USER svc

ENTRYPOINT /run.sh

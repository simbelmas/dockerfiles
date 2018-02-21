FROM fedora
RUN dnf -y install pulseaudio \
    && dnf -y install pulseaudio-utils \
    && dnf clean all

RUN useradd -m svc \
  && usermod -a -G audio,video svc

COPY pulse-client.conf /home/svc/.config/pulse/client.conf
RUN chown svc: /home/svc/ -R

ENV HOME /home/svc
USER svc

ENTRYPOINT /bin/bash

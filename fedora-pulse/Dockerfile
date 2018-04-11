FROM fedora
RUN dnf -y install pulseaudio \
    && dnf -y install pulseaudio-utils \
    && dnf clean all
RUN groupadd svc \
  && useradd -g svc -m svc  \
  && usermod -a -G audio,video svc

COPY pulse-client.conf /home/svc/.config/pulse/client.conf
RUN chown svc: /home/svc/ -R

ENTRYPOINT /bin/bash

From quay.io/simbelmas/fedora-minimal:v41.35@sha256:de452fd3d9316b7d14619062b0e6f9e73988bd528022490e924b4b05433dbc5a

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install \
    openssh-server zsh \
    && microdnf clean all

RUN mkdir -p /app/.ssh

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app \
    && sed -E 's/^.*PasswordAuthentication.*$/PasswordAuthentication no/g' -i /etc/ssd/sshd_config

WORKDIR /app

ENTRYPOINT ["/usr/sbin/sshd","-D"]

From quay.io/simbelmas/fedora-minimal:v41.33@sha256:9dfc2e27eee3c65ce6d5247710c403c142937c59e7f6f4d9e2807d3961bf4d65

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
    && sed -r 's/^.*PasswordAuthentication.*$/PasswordAuthentication no/g' -i /etc/ssh/sshd_config

WORKDIR /app

ENTRYPOINT ["/usr/sbin/sshd","-D"]

FROM quay.io/simbelmas/fedora-minimal:v38.29@sha256:c94e1dac3dab6e69e63cdd473fd96131d53b3b664caf239a6af205c94d653c07
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd

RUN cd /usr/local/bin \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod a+x kubectl

RUN cd /usr/local/bin \
    && curl -o argocd -L https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 \
    && chmod a+x argocd

RUN mkdir /app \
    && chown -Rv app:app /app \
    && chmod 750 /app

USER 1001
WORKDIR /app

ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["--help"]


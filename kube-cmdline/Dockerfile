FROM quay.io/simbelmas/fedora-minimal:v38.26@sha256:828891d431b7f85a386d0ffa896c2344996114ec342f818247ca9ce88a05016a
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


FROM quay.io/simbelmas/fedora-minimal:v41.19@sha256:4b29fa1b47264d266890d71d5dbeded96eb287ec42bd6376f8d923146fa51fdf
LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'app:x:1001:' >> /etc/group \
    && echo 'app:x:1001:1001::/app:/sbin/nologin' >> /etc/passwd \
    && mkdir -p /app \
    && chmod -R 700 /app \ 
    && chown -R app:app /app

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


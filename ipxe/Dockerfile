FROM quay.io/simbelmas/nginx:v0.159@sha256:b8e5ad238c20e847175fb23ae05fc2c10a138d48e5b1b4885a24f376d29effc7

LABEL maintainer "Simon Belmas <slos@soket.fr>"

USER 0

RUN microdnf --nodocs -y install dnsmasq \
    python3-jinja2-cli jq yq git butane pykickstart \
    zsh \
    && microdnf clean all

    # debug tools
    #RUN microdnf --nodocs --best -y install tftp iproute procps-ng \
    #    && microdnf clean all

COPY site-default.conf /etc/nginx/kube/default.conf
COPY zshrc /var/www/.zshrc
COPY run-service.zsh /var/www/run-service.zsh
COPY generate_ipxe_chainload.zsh /var/www/generate_ipxe_chainload.zsh
COPY dnsmasq-tftp.conf /etc/dnsmasq.conf

RUN chown app:app /var/www/.zshrc /var/www/*.zsh /etc/dnsmasq.conf \
    && chmod 0700 /var/www/*.zsh \
    && rm -rf /var/www/html/*

WORKDIR /var/www

#USER 1001

EXPOSE 8080/tcp
EXPOSE 69/udp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/var/www/run-service.zsh"]



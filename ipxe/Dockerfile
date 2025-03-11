#FROM quay.io/simbelmas/nginx:v0.87@sha256:aec04086bc85ad7751187257ff905c1973eb5e1b68c29572cd65191505724e25
FROM registry.fedoraproject.org/fedora-minimal:40

USER 0

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs -y install dnsmasq \
    python3-jinja2-cli jq yq git \
    zsh \
    && microdnf clean all

    # debug tools
    #RUN microdnf --nodocs --best -y install tftp iproute procps-ng \
    #    && microdnf clean all

COPY site-default.conf /etc/nginx/kube/default.conf
COPY zshrc /var/www/.zshrc
COPY run-service.zsh /var/www/run-service.zsh
COPY get_pxe_fedora_coreos.zsh /var/www/get_pxe_fedora_coreos.zsh
COPY generate_ipxe_chainload.zsh /var/www/generate_ipxe_chainload.zsh
COPY dnsmasq-tftp.conf /etc/dnsmasq.conf

RUN chown app:app /var/www/.zshrc /var/www/*.zsh /etc/dnsmasq.conf \
    && chmod 0700 /var/www/*.zsh \
    && rm -rf /var/www/html/*

WORKDIR /var/www

#USER 1001

EXPOSE 8080/tcp
EXPOSE 8069/udp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/var/www/run-service.zsh"]



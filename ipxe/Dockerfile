FROM quay.io/simbelmas/nginx:v0.86

USER 0

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN microdnf --nodocs --best -y install tftp-server zsh jq \
    && microdnf --nodocs --best -y install  busybox sudo \
    && microdnf clean all

COPY site-default.conf /etc/nginx/kube/default.conf
COPY zshrc /var/www/.zshrc
COPY run-service.zsh /var/www/run-service.zsh
COPY get_pxe_fedora_coreos.zsh /var/www/get_pxe_fedora_coreos.zsh
COPY generate_ipxe_chainload.zsh /var/www/generate_ipxe_chainload.zsh

RUN chown app:app /var/www/.zshrc /var/www/*.zsh \
    && chmod 0700 /var/www/*.zsh \
    && rm -rf /var/www/html/*

WORKDIR /var/www

#USER 1001

EXPOSE 8080/tcp
EXPOSE 8069/udp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/var/www/run-service.zsh"]



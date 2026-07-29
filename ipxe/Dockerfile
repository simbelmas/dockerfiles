FROM quay.io/simbelmas/nginx:v44.14@sha256:870c5890ffad56958d9e11f755b438a57ab41d109ec4dc3191588aa2b2bdc487

LABEL maintainer "Simon Belmas <slos@soket.fr>"

USER 0

RUN microdnf --nodocs -y install dnsmasq \
    python3-jinja2-cli jq yq git git-crypt butane pykickstart bind-utils \
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



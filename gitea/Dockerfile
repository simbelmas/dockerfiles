FROM quay.io/simbelmas/fedora-minimal:v37.9@sha256:9ba4ce54abfd8857af0bf74d54051cbddcd6f602c565983407e314df42164267

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN echo 'www-data:x:82:' >> /etc/group \
    && echo 'app:x:1001:82::/var/lib/gitea:/sbin/nologin' >> /etc/passwd

RUN mkdir -p /var/lib/gitea/{custom,data,git,log} /usr/share/gitea /var/lib/gitea/custom/public/css

COPY ./theme-earl-grey/theme-earl-grey.css /usr/local/bin/custom/public/css/

RUN chmod 750 /var/lib/gitea -R \
    && microdnf -y install jq wget git \
    && cd /usr/local/bin/ \
    && if [ -n "${app_version}" ] ; then export app_last_stable_release="${app_version}" ; else export app_last_stable_release=$(curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | jq -r .tag_name | sed 's/^v//') ; fi \
    && if [ "${TARGETARCH}" = "aarch64" ] ; then export build_arch="arm64" ; else export build_arch="${TARGETARCH}" ; fi \
    && echo "Will download version ${app_last_stable_release} for arch ${build_arch}" \
    && wget -O gitea https://dl.gitea.io/gitea/${app_last_stable_release}/gitea-${app_last_stable_release}-linux-${build_arch} \
    && wget -O /tmp/gitea.asc https://dl.gitea.io/gitea/${app_last_stable_release}/gitea-${app_last_stable_release}-linux-${build_arch}.asc \
    && gpg2 --keyserver keys.openpgp.org --recv 7C9E68152594688862D62AF62D9AE806EC1592E2 \
    && gpg2 --verify /tmp/gitea.asc /usr/local/bin/gitea \
    && rm /tmp/gitea.asc \
    && chmod a+x gitea \
    && chown 1001:82 /var/lib/gitea \
    && chmod o-rwx /var/lib/gitea -R \
    && microdnf -y remove jq wget \
    && microdnf clean all \
    && git clone --depth 1 --branch v${app_last_stable_release} https://github.com/go-gitea/gitea.git /gitea_build \
    && mv /gitea_build/options /usr/share/gitea/ \
    && mv /gitea_build/public /usr/share/gitea/ \
    && mv /gitea_build/templates /usr/share/gitea/ \
    && rm -rf /gitea_build 

RUN chown -Rv app:www-data /var/lib/gitea \
    && chmod g+rwX /var/lib/gitea -R \
    && chmod 750 /var/lib/gitea

WORKDIR /var/lib/gitea
ENTRYPOINT ["/usr/local/bin/gitea","web"]
CMD ["-c", "/var/lib/gitea/custom/conf/app.ini"]

USER 1001

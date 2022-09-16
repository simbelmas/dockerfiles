FROM docker.io/alpine:latest

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apk --no-cache add git \
    && mkdir -p /var/lib/gitea/custom/conf /usr/share/gitea \
    && apk --no-cache -t dev_tools add make musl-dev go curl npm gcc \
    && mkdir -p ${GOPATH}/src ${GOPATH}/bin \
    && export gitea_last_stable_release=$(curl -s https://api.github.com/repos/go-gitea/gitea/releases/latest | grep tag_name | cut -d '"' -f 4) \
    && git clone --depth 1 --branch $gitea_last_stable_release https://github.com/go-gitea/gitea.git /gitea_build \
    && cd /gitea_build \
    && export GOROOT=/usr/lib/go \
    && export GOPATH=/go \
    && export PATH=/go/bin:$PATH \
    && export TAGS="bindata" \
    && export LDFLAGS="-X \"code.gitea.io/gitea/modules/setting.CustomPath=/var/lib/gitea/custom\" -X \"code.gitea.io/gitea/modules/setting.AppWorkPath=/var/lib/gitea\" -X \"code.gitea.io/gitea/modules/setting.StaticRootPath=/usr/share/gitea\"" \
    && make build \
    && apk del dev_tools \
    && mv /gitea_build/options /usr/share/gitea/ \
    && mv /gitea_build/public /usr/share/gitea/ \
    && mv /gitea_build/templates /usr/share/gitea/ \
    && mv /gitea_build/gitea /usr/bin/ \
    && chmod a+rx /usr/bin/gitea \
    && rm -rvf /gitea_build ${GOPATH} /tmp/* /root/.cache

COPY app.ini /var/lib/gitea/custom/conf/app.ini

RUN adduser -G www-data -D -H -h /var/lib/gitea -u 1001 gitea \
    && chown -Rv gitea:www-data /var/lib/gitea \
    && chmod g+rwX /var/lib/gitea -R \
    && chmod 750 /var/lib/gitea

USER 1001

CMD ["/usr/bin/gitea","web"]
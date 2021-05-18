ARG baseimg=docker.io/multiarch/alpine:x86_64-latest-stable
FROM $baseimg

LABEL maintainer "Simon Belmas <slos@soket.fr>"
#Compile imapfilter
RUN apk --no-cache add mariadb mariadb-client mariadb-mytop

RUN deluser mysql \
    && addgroup -g 1001 mysql \
    && adduser -G mysql -D -H -h /var/lib/mysql -u 1001 -s /bin/nologin mysql \
    && mkdir /var/run/mysql \
    && chown -Rv 1001:1001 /var/lib/mysql /var/run/mysql \
    && ln -s /dev/stdout /var/log/map_stdout  \
    && ln -s /dev/stdout /var/log/map_stdout.err \
    && rm /etc/my.cnf.d/mariadb-server.cnf

COPY container_mariadb.cnf /etc/my.cnf.d/container_mariadb.cnf
COPY start_mariadb /usr/local/bin/start_mariadb

RUN chmod 755 /usr/local/bin/start_mariadb

USER 1001

ENTRYPOINT ["/usr/local/bin/start_mariadb"]

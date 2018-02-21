FROM quay.io/simbelmas/alpine:latest@sha256:f271e74b17ced29b915d351685fd4644785c6d1559dd1f2d4189a5e851ef753a

LABEL maintainer "Simon Belmas <slos@soket.fr>"
#Compile imapfilter
RUN apk --no-cache add mariadb mariadb-client mariadb-mytop mariadb-server-utils

RUN deluser mysql \
    && addgroup -g 1001 mysql \
    && adduser -G mysql -D -H -h /var/lib/mysql -u 1001 -s /bin/nologin mysql \
    && mkdir /var/run/mysqld \
    && chown -Rv mysql: /var/lib/mysql /var/run/mysqld /etc/my.cnf.d \
    && ln -s /dev/stdout /var/log/map_stdout  \
    && ln -s /dev/stdout /var/log/map_stdout.err \
    && rm /etc/my.cnf.d/mariadb-server.cnf

COPY container_mariadb.cnf /etc/my.cnf.d/container_mariadb.cnf
COPY start_mariadb /usr/local/bin/start_mariadb

RUN chmod 755 /usr/local/bin/start_mariadb

USER 1001

ENTRYPOINT ["/usr/local/bin/start_mariadb"]

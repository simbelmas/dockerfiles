FROM quay.io/simbelmas/ubuntu:v2410.37@sha256:375a1f82113753d9a2c651001476f64f880cd5f522f744efab1ac2d26c2b6bb1 AS Downloader

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN apt-get update \
    && apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/cache/apt/* 
RUN set -x \
    && deluser mysql \
    && groupadd -g 1001 mysql \
    && useradd --gid mysql -d /var/lib/mysql -u 1001 -s /bin/nologin mysql \
    && mkdir /var/run/mysqld /etc/my.cnf.kube.d \
    && ln -s /dev/stdout /var/log/map_stdout  \
    && ln -s /dev/stdout /var/log/map_stdout.err \
    && chown -R mysql: /var/lib/mysql /run/mysqld /etc/mysql /etc/my.cnf.kube.d \
    && rm /etc/mysql/*cnf \
    && sed -i '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY container_mariadb.cnf /etc/mysql/my.cnf
COPY start_mariadb /usr/local/bin/start_mariadb

RUN chmod 755 /usr/local/bin/start_mariadb

USER 1001

ENTRYPOINT ["/usr/local/bin/start_mariadb","--skip-log-error"]

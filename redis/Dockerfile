FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:af0be38eb8e43191bae9b03fe5c928803930b6f93e2dde3a7ad1165c04b1ce22

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


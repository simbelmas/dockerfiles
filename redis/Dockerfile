FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:e647cfe134bf5e8e74e620f66346f93418acfc240b71dd85640325cb7cd01402

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:08a82d4bf8a8b4dd94e8f5408cdbad9dd184c1cf311d34176cd3e9972c43f872

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


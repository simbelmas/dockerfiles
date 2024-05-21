FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:b32ea6ea4d5b38496c6e93d02083e97f461cb09d6b8672462b53071236ef4b12

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:f92a0be0ba8c085e6a5e2d2bea386365443485bcd67ced5ca8ddcdacdd4656d2

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


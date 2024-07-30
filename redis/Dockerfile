FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:79676a8f74e4aed85b6d6a2f4e4e3e55d8a229baa7168362e592bbfdc67b0c9b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


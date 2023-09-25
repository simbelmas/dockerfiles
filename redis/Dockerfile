FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:ae51486efeea8a9b3f85542e408f79a5012d5b7fa35ae19733104ecc6992a248

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


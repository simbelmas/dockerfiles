FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:5a82749600e03e4c4208276283f1f39d2dfde31700582c5a0b3e4ab48a2ddf7e

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


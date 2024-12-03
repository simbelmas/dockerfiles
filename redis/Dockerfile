FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:3d5468f5073ab1b54c1875afa987b5eeeb31143d03aa5224e950f7c2dc51353b

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


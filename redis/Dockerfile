FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:878983f8f5045b28384fc300268cec62bca3b14d5e1a448bec21f28cfcc7bf78

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


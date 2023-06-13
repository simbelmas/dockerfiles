FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:057e1fb9020a843d37b463c5cbe73235ee14804936ee4b5a3f2648db0215ab11

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


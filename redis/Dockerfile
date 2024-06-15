FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:f5ef9e24a9ef3b7cc552ae0cbc3cbade4f2877502683496c5d775605ae071412

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


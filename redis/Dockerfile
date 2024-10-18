FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:0e69d581912e77276656022e2a7f2d51bf25859a8f3792f1bf0f4be632754801

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


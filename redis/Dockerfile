FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:1fedceefa4b1c5b90c22c58eff380647712c52d7b895928098b5d8a84d4e09bb

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


FROM quay.io/simbelmas/redis:dockerio-latest-mirror@sha256:01afb31d6d633451d84475ff3eb95f8c48bf0ee59ec9c948b161adb4da882053

LABEL maintainer "Simon Belmas <slos@soket.fr>"

RUN mkdir -p /usr/local/etc/redis/drop-ins
COPY redis.conf /usr/local/etc/redis/redis.conf
RUN chown -Rv redis:redis /usr/local/etc/redis /data

WORKDIR /home/redis
USER 999

ENTRYPOINT ["redis-server"]
CMD ["/usr/local/etc/redis/redis.conf"]


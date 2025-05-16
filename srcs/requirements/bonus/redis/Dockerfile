FROM debian:bullseye

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y redis-server && \
	rm -rf /var/lib/apt/lists/* && \
	sed -i -e "s|bind 127.0.0.1|bind 0.0.0.0|g" \
	-e "s|daemonize yes|daemonize no|g" \
	-e "s|protected-mode yes|protected-mode no|g" \
	-e "s|# maxmemory <bytes>|maxmemory 20mb|g" \
	-e "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" \
	/etc/redis/redis.conf

CMD [ "redis-server" , "/etc/redis/redis.conf" ]
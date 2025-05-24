FROM debian:bullseye

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y redis-server && \
	rm -rf /var/lib/apt/lists/* && \
	sed -i -e "s|^bind.*|bind 0.0.0.0|" \
	-e "s|^daemonize.*|daemonize no|" \
	-e "s|^protected-mode.*|protected-mode no|" \
	-e "s|^# maxmemory.*|maxmemory 20mb|" \
	-e "s|^# maxmemory-policy.*|maxmemory-policy allkeys-lru|" \
	/etc/redis/redis.conf

CMD [ "redis-server" , "/etc/redis/redis.conf" ]
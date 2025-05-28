FROM debian:bullseye

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y wget && \
	rm -rf /var/lib/apt/lists/* && \
	wget --no-check-certificate https://github.com/portainer/portainer/releases/download/2.27.3/portainer-2.27.3-linux-amd64.tar.gz -O /tmp/portainer.tar.gz && \
	tar xzf /tmp/portainer.tar.gz --strip-components=1 -C /usr/bin/ && \
	rm /tmp/portainer.tar.gz

CMD [ "portainer", "-H", "unix:///var/run/docker.sock" ]

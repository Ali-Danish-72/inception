FROM debian:bullseye

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y vsftpd openssl && \
	rm -rf /var/lib/apt/lists/*

COPY configuration/config.sh /usr/bin/config.sh

RUN chmod +x /usr/bin/config.sh

CMD [ "config.sh" ]

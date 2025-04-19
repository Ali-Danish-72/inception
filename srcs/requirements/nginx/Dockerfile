FROM debian:bullseye

RUN apt-get update --no-install-recommends -y && \
	apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y nginx openssl

COPY ./conf/config.sh /usr/bin/

RUN chmod +x /usr/bin/config.sh

CMD ["config.sh"]

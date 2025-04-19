FROM debian:bullseye

RUN apt-get update --no-install-recommends -y && \
	apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y curl php-fpm php-mysql php-curl php-mbstring	ca-certificates && \
	rm -rf /var/lib/apt/*

RUN curl -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY ./conf/config.sh /usr/bin/

RUN chmod +x /usr/bin/config.sh

CMD ["config.sh"]

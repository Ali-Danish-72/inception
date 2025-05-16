FROM debian:bullseye

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS
ARG DB_CONF_ROUTE

RUN apt-get update && apt-get upgrade --no-install-recommends -y && \
	apt-get install --no-install-recommends -y mariadb-server && \
	rm -rf /var/lib/apt/lists/* && \
	sed -i 's|^bind-address.*|bind-address = 0.0.0.0|' $DB_CONF_ROUTE

COPY ./configuration/config.sh /usr/bin/

RUN chmod +x /usr/bin/config.sh && service mariadb start && config.sh

CMD ["mysqld_safe"]

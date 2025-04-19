#! /usr/bin/env bash

mkdir $CERT_DIR
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $CERT_KEY -out $CERT -subj "/C=AE/ST=Abu Dhabi/L=Abu Dhabi/O=42/OU=Dev/CN=$HOST_NAME"

echo "server {
	server_name $HOST_URL;

	listen 443 ssl http2;
	ssl_certificate $CERT;
	ssl_certificate_key $CERT_KEY;
	ssl_protocols TLSv1.2 TLSv1.3;

	root $WP_ROUTE;
	index index.html index.php index.htm index.nginx-debian.html;

	location / {
		try_files \$uri \$uri/ /index.php?\$args =404;
	}

	location ~ \.php\$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass wordpress:9000;
	}
}" > $NGINX_CONF;

nginx -g 'daemon off;'

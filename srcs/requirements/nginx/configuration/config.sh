#! /usr/bin/env bash

# Create the SSL certificate for NGINX and directory that will contain it.
mkdir -p $CERT_DIR
mkdir -p $KEY_DIR
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY -out $CERT -subj "/C=AE/ST=Abu Dhabi/L=Abu Dhabi/O=42/OU=Dev/CN=$HOST_NAME"

# Create the NGINX configuration file.
echo "# Server block for the general website
server {
	server_name $HOST_NAME;

	listen 443 ssl http2;
	ssl_certificate $CERT;
	ssl_certificate_key $KEY;
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
}

# Server block for Adminer
server {
	server_name $HOST_NAME;

	listen 8080 ssl http2;
	ssl_certificate $CERT;
	ssl_certificate_key $KEY;
	ssl_protocols TLSv1.2 TLSv1.3;

	root $ADMINER_ROUTE;
	index index.php;

	location / {
		try_files \$uri \$uri/ /index.php?\$args =404;
	}

	location ~ \.php\$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass adminer:9000;
	}
}" > $NGINX_CONF;

# Run NGINX.
nginx -g 'daemon off;'

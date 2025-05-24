#! /usr/bin/env bash

# Create and configure the ftp user to be used when a client will connect.
adduser --home /home/$FTP_USER --disabled-password $FTP_USER
adduser $FTP_USER www-data
echo $FTP_USER:$FTP_PASS | chpasswd

# Configure the root directory of the ftp user to mitigate risks related chroot(),
chown root:root /home/$FTP_USER
chmod 755 /home/$FTP_USER

# Create the SSL Certificates for FTPS.
mkdir -p $CERT_DIR
mkdir -p $KEY_DIR
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEY -out $CERT \
	-subj "/C=AE/ST=Abu Dhabi/L=Abu Dhabi/O=42/OU=Dev/CN=$HOST_NAME"

# Update the default configuration file with custom configuration.
sed -i	-e "s|^#write_enable.*|write_enable=YES|" \
		-e "s|^#ftpd_banner.*|ftpd_banner=You have found the source code. Go wild!|" \
		-e "s|^#chroot_local_user.*|chroot_local_user=YES|" \
		-e "s|^#local_umask.*|local_umask=002|" \
		-e "s|^rsa_cert_file.*|rsa_cert_file=$CERT|" \
		-e "s|^rsa_private_key_file.*|rsa_private_key_file=$KEY|" \
		-e "s|^ssl_enable.*|ssl_enable=YES|" /etc/vsftpd.conf
echo 'pasv_min_port=21' >> /etc/vsftpd.conf
echo 'pasv_max_port=30' >> /etc/vsftpd.conf
echo 'seccomp_sandbox=NO' >> /etc/vsftpd.conf
echo 'require_ssl_reuse=NO' >> /etc/vsftpd.conf
echo 'ssl_ciphers=HIGH' >> /etc/vsftpd.conf

# Create the directory from within with the daemon will run.
mkdir -p /var/run/vsftpd/empty

# Execute the daemon with the updated configuration file.
vsftpd /etc/vsftpd.conf

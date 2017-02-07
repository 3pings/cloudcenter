#!/bin/bash
# Remove old PHP packages

yum remove php.x86_64 php-cli.x86_64 php-common.x86_64 php-gd.x86_64 php- ldap.x86_64 php-mbstring.x86_64 php-mcrypt.x86_64 php-mysql.x86_64 php- pdo.x86_64 -y
# Configuring new repo for PHP55

rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
# Installing new PHP packages for owncloud

yum install -y php55w php55w-mysql php55w-xml php55w-gd php55w-mbstring -y

# Creating ownCloud data directory, assign ownership and permissions
mkdir -p /var/owncloud_data
chown -R apache:apache /var/owncloud_data/
# chmod -R 755 /var/owncloud_data

# Create a new VirtualHost in the default virtual host configuration file and enable HTTPS redirection
echo "<VirtualHost *:80>Redirect permanent https://$CliqrTier_WEB_PUBLIC_IP/owncloud</VirtualHost>" >> /etc/httpd/sites- enabled/default-ssl
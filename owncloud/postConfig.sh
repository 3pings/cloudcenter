#!/usr/bin/bash

# Source the Cloudcenter user env file to onboard C3 specifc vars
source /usr/local/cliqr/etc/userenv

# Referencing DB credentials and target IPs
OWNCLOUD_DB_USER=owncloud
OWNCLOUD_DB_PASS=ownpassword
OWNCLOUD_DB_NAME=cloud
OWNCLOUD_DB_HOST=$CliqrTier_MySQL_PUBLIC_IP

# Restart Apache before submitting the POST
sudo service httpd restart

# Run first time configuration for HTTPS
curl --data "install=true&adminlogin=$OWNCLOUD_ADMIN_USER&adminpass=$OWNCLOUD_ADMIN_PASS&adm inpass-
clone=$OWNCLOUD_ADMIN_PASS&directory=%2Fvar%2Fowncloud_data&dbtype=mysql&dbuser= $OWNCLOUD_DB_USER&dbpass=$OWNCLOUD_DB_PASS&dbpass-
clone=$OWNCLOUD_DB_PASS&dbname=$OWNCLOUD_DB_NAME&dbhost=$OWNCLOUD_DB_HOST"
"https://localhost/owncloud/index.php" -k

# Wait before accessing config.php as it won't be immediately ready after first configuration
sleep 30

# Backup config.php and set Owncloud public IP as trusted
sudo cp /var/www/owncloud/config/config.php
/var/www/owncloud/config/config.php.bck
sudo sed -i s/localhost/$CliqrTier_WEB_PUBLIC_IP/g
/var/www/owncloud/config/config.php
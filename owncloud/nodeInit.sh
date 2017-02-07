#!/bin/bash

# Declare variables for certificate
gen CERT_DIR="/usr/local/osmosix/cert"
COUNTRY="US"
STATE="PA"
CITY="Pittsburgh"
ORG="REQLAB"
ORG_UNIT="Sales" COMMON_NAME="owncloud.threepings.com"

# Prepare certificates for HTTPS
sudo mkdir -p $CERT_DIR
sudo openssl req -nodes -newkey rsa:2048 -keyout $CERT_DIR/private.key -out $CERT_DIR/CSR.csr -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORG/OU=$ORG_UNIT/CN=$COMMON_NAME"
sudo openssl rsa -in $CERT_DIR/private.key -out $CERT_DIR/vm.cliqr.com.key
sudo openssl x509 -in $CERT_DIR/CSR.csr -out $CERT_DIR/vm.cliqr.com.cert -req - signkey $CERT_DIR/vm.cliqr.com.key
sudo cp $CERT_DIR/vm.cliqr.com.cert $CERT_DIR/vm.cliqr.com.crt
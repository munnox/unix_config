#!/bin/bash
# Simple script to build a certificate authority
# To be able to understand the rule so on every installation
# I can change them
# Wanting this system simple and documented as I plan to
# build and rebuild CA's often to keep the target moving

ROOT_CA_PATH="./test"
INT_CA_PATH="$ROOT_CA_PATH/intermediate"

# Directory Setup for Root CA

mkdir $ROOT_CA_PATH
cd $ROOT_CA_PATH
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# Copy Openssl Config
cp root_ca_openssl.cnf $ROOT_CA_PATH/openssl.cnf

# Create and protect Root Key
openssl genrsa -aes256 -out $ROOT_CA_PATH/private/ca.key.pem 4096
chmod 400 $ROOT_CA_PATH/private/ca.key.pem

# Create and protect Root Certificate
openssl req -config openssl.cnf \
    -key $ROOT_CA_PATH/private/ca.key.pem \
    -new -x509 -days 7300 -sha256 -extensions v3_ca \
    -out $ROOT_CA_PATH/certs/ca.cert.pem
chmod 444 $ROOT_CA_PATH/certs/ca.cert.pem

# Directory Setup for Intermediate CA

cd $INT_CA_PATH
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

# Copy Openssl Config
cp intermediate_ca_openssl.cnf $INT_CA_PATH/openssl.cnf

# Create and protect Intermedary Key
openssl genrsa -aes256 \
    -out $INT_CA_PATH/private/intermediate.key.pem 4096
chmod 400 $INT_CA_PATH/private/intermediate.key.pem

# Create Certificate Request
openssl req -config $INT_CA_PATH/openssl.cnf -new -sha256 \
    -key $INT_CA_PATH/private/intermediate.key.pem \
    -out $INT_CA_PATH/csr/intermediate.csr.pem

# Sign and protect the Request with root CA
openssl ca -config /root/ca/openssl.cnf -extensions v3_intermediate_ca \
    -days 3650 -notext -md sha256 \
    -in $INT_CA_PATH/csr/intermediate.csr.pem \
    -out $INT_CA_PATH/certs/intermediate.cert.pem
chmod 444 $INT_CA_PATH/certs/intermediate.cert.pem

# Create the certificate chain file
cat $INT_CA_PATH/certs/intermediate.cert.pem \
    /root/ca/certs/ca.cert.pem > $INT_CA_PATH/certs/ca-chain.cert.pem
chmod 444 $INT_CA_PATH/certs/ca-chain.cert.pem

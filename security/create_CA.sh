#!/bin/bash

# Info from https://www.itsfullofstars.de/2017/02/openssl-ca-to-sign-csr-with-sha256-create-ca/

openssl genrsa -aes256 -out ca.key.pem 4096

# openssl rsa –in ca.key.pem -check

#Create Public Certificate

openssl req -key ca.key.pem -new -x509 -days 5000 -sha256 -extensions v3_ca -out ca.cert.pem

# Check public certificate
# openssl x509 -in ca.cert.pem -text -noout

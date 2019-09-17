#!/bin/bash

# From https://www.itsfullofstars.de/2017/02/openssl-ca-to-sign-csr-with-sha256-sign-csr-issued-with-sha-1/

#Create CSR using SHA-1
openssl req -out sha1.csr -new -newkey rsa:2048 -nodes -keyout sha1.key

#Check CSR
openssl req -verify -in sha1.csr -text -noout

# Sign CSR enforcing SHA-256
openssl x509 -req -days 360 -in sha1.csr -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -out sha1.crt -sha256

# Check signed certificate
openssl x509 -text -noout -in sha1.crt



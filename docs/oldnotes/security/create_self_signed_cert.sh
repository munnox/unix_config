#!/bin/bash

# From https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl

# Create a Simple self signed certifcate valid for a year
# openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
function selfcert {
FILE=example-com.conf
if test -f "$FILE"; then
    echo "File already create"
else
    echo "Creating file $FILE"
    cat << EOF > $FILE
[ req ]
default_bits       = 2048
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[ req_distinguished_name ]
countryName                 = Country Name (2 letter code)
stateOrProvinceName         = State or Province Name (full name)
localityName               = Locality Name (eg, city)
organizationName           = Organization Name (eg, company)
commonName                 = Common Name (e.g. server FQDN or YOUR name)
[ req_ext ]
subjectAltName = @alternate_names
[ alternate_names ]

DNS.1       = example.com
DNS.2       = www.example.com
DNS.3       = mail.example.com
DNS.4       = ftp.example.com

# Add these if you need them. But usually you don't want them or
#   need them in production. You may need them for development.
# DNS.5       = localhost
# DNS.6       = localhost.localdomain
# IP.1        = 127.0.0.1
# IP.2        = ::1
EOF
fi
# openssl req -config example-com.conf -new -x509 -sha256 -newkey rsa:2048 -nodes \
#     -keyout example-com.key.pem -days 365 -out example-com.cert.pem


openssl req -config example-com.conf -new -x509 -sha256 -newkey rsa:2048 \
    -keyout example-com.key.pem -days 365 -out example-com.cert.pem

}

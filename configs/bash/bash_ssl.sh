#!/bin/bash

# Certificate and key handling
# Mostly for reference and further derivation

function ram-ssl-print-key() {
  KEY_PATH=${1:-./server.key}
  echo "Print key '${KEY_PATH}'"
  # Check / Print private key
  openssl rsa -check -in ${KEY_PATH}
}

function ram-ssl-print-cert() {
  CERT_PATH=${1:-./server.crt}
  echo "Print certificate '${CERT_PATH}'"
  # Check / Print Certificate
  openssl x509 -text -noout -in ${CERT_PATH}
}

function ram-ssl-print-request() {
  REQUEST_PATH=${1:-./server.csr}
  echo "Print certificate request '${REQUEST_PATH}'"
  # Check / Print Certificate
  openssl req -text -noout -verify -in ${REQUEST_PATH} -verbose 
}

# Generate CA
function ram-ssl-create-ca() {
  # Info from https://www.itsfullofstars.de/2017/02/openssl-ca-to-sign-csr-with-sha256-create-ca/
  # more info from https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
  # Other ref tw:OpenSSL/Example Commands
  # CA_PATH=${1:=./}
  CA_KEY=${1:=./ca.key}
  CA_CERT=${2:=./ca.crt}
  echo "Create a CA with key in '${CA_KEY}' and cert in '${CA_CERT}'"

  # Generate a private key
  openssl genrsa -aes256 -out ${CA_KEY} 4096

  # Check private key
  # openssl rsa –in ca.key.pem -check

  # Create Public Certificate

  # Doesn't work....
  # found more modern reference https://arminreiter.com/2022/01/create-your-own-certificate-authority-ca-using-openssl/
  # openssl req -key ${CA_PATH}ca.key.pem -new -x509 -days 5000 -sha256 -extensions v3_ca -out ${CA_PATH}ca.cert.pem
  # openssl req -key ${CA_PATH}ca.key.pem -new -x509 -days 5000 -sha256 -out ${CA_PATH}ca.cert.pem

  # Check public certificate
  # openssl x509 -in ca.cert.pem -text -noout

  openssl req -x509 -new -nodes -key $CA_KEY -sha256 -days 1826 -out $CA_CERT
  # ... or you provide common name, country etc. via:
  # openssl req -x509 -new -nodes -key $CA_KEY -sha256 -days 1826 -out $CA_CERT -subj '/CN=Munnox Root CA/C=GB/ST=Birmingham/L=Birmingham/O=Munnox'
}

function ram-ssl-create-csr() {
  KEY_PATH=${1:=./server.key}
  CERT_PATH=${2:=./server.csr}
  echo "Create a Certificate request with key '${KEY_PATH}' and cert '${CERT_PATH}'"
  #Create CSR using SHA-1
  openssl req -out ${CERT_PATH} -new -newkey rsa:2048 -nodes -keyout ${KEY_PATH}

  # Check CSR
  # openssl req -verify -in server.csr -text -noout
}

function ram-ssl-create-cert-from-request() {
  # From https://www.itsfullofstars.de/2017/02/openssl-ca-to-sign-csr-with-sha256-sign-csr-issued-with-sha-1/
  CA_KEY=${1:=./ca.key}
  CA_CERT=${2:=./ca.crt}
  CERT_REQUEST_PATH=${3:=./server.csr}
  CERT_PATH=${4:=./server.crt}
  # KEY_PATH=${2:=./server.csr}
  echo "Using CA in '${CA_KEY}', '${CA_CERT}' and the certificate at '${CERT_REQUEST_PATH}' to create a certificate at '${CERT_PATH}'"

  # Sign CSR enforcing SHA-256
  openssl x509 -req -days 360 -in ${CERT_REQUEST_PATH} -CA ${CA_CERT} -CAkey ${CA_KEY} -CAcreateserial -out ${CERT_PATH} -sha256

  # Check signed certificate
  # openssl x509 -text -noout -in ${CERT_PATH}

}
# Generate the RSA certificate
function ram-ssl-save-cert-chain() {
  URL=$1
  CERTPATH=${2:-./$URL}
  PORT=443
  echo "Saving certs from '$URL' on '$PORT' into '$CERTPATH'"
  # Check path and create if it does not exist
  [[ ! -e $CERTPATH ]] && mkdir $CERTPATH
  openssl s_client -showcerts -verify 5 -connect $URL:$PORT < /dev/null |
     awk '/BEGIN CERTIFICATE/,/END CERTIFICATE/{ if(/BEGIN CERTIFICATE/){a++}; out="cert"a".pem"; print >out}'
  for cert in *.pem; do 
    newname=$CERTPATH/$(openssl x509 -noout -subject -in $cert | sed -nE 's/.*CN ?= ?(.*)/\1/; s/[ ,.*]/_/g; s/__/_/g; s/_-_/-/; s/^_//g;p' | tr '[:upper:]' '[:lower:]').crt
    echo "${newname}"; mv "${cert}" "${newname}" 
  done
}

function ram-ssl-create-self-signed() {
  KEY_PATH=${2:-./example-com.key.pem}
  CERT_PATH=${2:-./example-com.cert.pem}
  echo "Create cert and key self contained key placed in ${KEY_PATH} cert placed: ${CERT_PATH}"
  # Create a Simple self signed certifcate valid for a year
  openssl req -x509 -newkey rsa:4096 -keyout ${KEY_PATH} -out ${CERT_PATH} -days 365
}

function ram-ssl-create-self-signed-conf() {
  # From https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl

  CONF_PATH=${1:-./example-com.conf}

  cat << EOF > ${CONF_PATH}
[ req ]
default_bits       = 4048
distinguished_name = req_distinguished_name
req_extensions     = req_ext
[ req_distinguished_name ]
countryName                 = Country Name (2 letter code)
countryName_min					    = 2
countryName_max				    	= 2
countryName_default    			= UK
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
IP.1        = 127.0.0.1
IP.2        = ::1

# Add these if you need them. But usually you don't want them or
#   need them in production. You may need them for development.
# DNS.5       = localhost
# DNS.6       = localhost.localdomain
# IP.1        = 127.0.0.1
# IP.2        = ::1
EOF

  # openssl req -config example-com.conf -new -x509 -sha256 -newkey rsa:2048 -nodes \
  #     -keyout example-com.key.pem -days 365 -out example-com.cert.pem
}
  

function ram-ssl-create-self-signed-from-conf() {
  # From https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
  CONF_PATH=${1:-./example-com.conf}
  KEY_PATH=${2:-./example-com.key.pem}
  CERT_PATH=${2:-./example-com.cert.pem}
  echo "Creating a key from conf '${CONF_PATH}' saving key in '${KEY_PATH}' and cert in '${CERT_PATH}'"
  openssl req -config ${CONF_PATH} -new -x509 -sha256 -newkey rsa:2048 \
      -keyout ${KEY_PATH} -days 365 -out ${CERT_PATH}
}

function ram-ssl-install-certificates-linux() {
  # Derived from:
  # https://ubuntu.com/server/docs/security-trust-store
  # https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/
  CERT_PATH=${1:-./server.crt}
  CERT_EXTRA_PATH=/usr/local/share/ca-certificates/extra
  [[ ! -e $CERT_EXTRA_PATH ]] && sudo mkdir $CERT_EXTRA_PATH
  sudo cp $CERT_PATH $CERT_EXTRA_PATH
  sudo update-ca-certificates
}

function ram-ssl-install-certificates-pip() {
  # Derived from https://superuser.com/questions/665069/can-i-get-around-using-pip-install-cert
  CERT_PATH=${1:-./server.crt}
  CERT_EXTRA_PATH=/usr/local/share/ca-certificates/extra
  [[ ! -e $CERT_EXTRA_PATH ]] && sudo mkdir $CERT_EXTRA_PATH
  sudo cp $CERT_PATH $CERT_EXTRA_PATH
  python -m pip config set global.cert $CERT_EXTRA_PATH/$CERT_PATH

}
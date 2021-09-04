# checking private certificates and keys

# https://www.sslshopper.com/certificate-key-matcher.html

## debug certs

## check an ssl connection while printing all certs
openssl s_client -connect www.paypal.com:443

# check private key checksum
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
# check certificate checksum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
# check certificate request# check certificate checksum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum


# Check cert
## Check a Certificate Signing Request (CSR)
openssl req -text -noout -verify -in CSR.csr

## Check a private key
openssl rsa -in privateKey.key -check

## Check a certificate
openssl x509 -in certificate.crt -text -noout

## Check a PKCS#12 file (.pfx or .p12)
openssl pkcs12 -info -in keyStore.p12

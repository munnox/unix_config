# checking private certificates and keys

# https://www.sslshopper.com/certificate-key-matcher.html

# check private key
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum 
# check certificate
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum 
# check certificate request# check certificate
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum


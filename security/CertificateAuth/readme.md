# Build a cert authority

* Source https://jamielinux.com/docs/openssl-certificate-authority/introduction.html


## Root Certificate

Basic setup

```
mkdir /root/ca
cd /root/ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
```

Move config file:

`cp root_ca_openssl.cnf /root/ca/openssl.cnf`

Further info on web or [here](./security/CertificateAuth/Further_info_on_config.md)

### Create the root key

```
cd /root/ca
openssl genrsa -aes256 -out private/ca.key.pem 4096
```

> Enter pass phrase for ca.key.pem: secretpassword
> Verifying - Enter pass phrase for ca.key.pem: secretpassword

```
chmod 400 private/ca.key.pem
```

### Create the root certificate

```
cd /root/ca
openssl req -config openssl.cnf \
    -key private/ca.key.pem \
    -new -x509 -days 7300 -sha256 -extensions v3_ca \
    -out certs/ca.cert.pem
```

> Enter pass phrase for ca.key.pem: secretpassword
> You are about to be asked to enter information that will be incorporated
> into your certificate request.
> -----
> Country Name (2 letter code) [XX]:GB
> State or Province Name []:England
> Locality Name []:
> Organization Name []:Alice Ltd
> Organizational Unit Name []:Alice Ltd Certificate Authority
> Common Name []:Alice Ltd Root CA
> Email Address []:

```
chmod 444 certs/ca.cert.pem
```

### Verify the root certificate

```
openssl x509 -noout -text -in certs/ca.cert.pem
```

## Create Intermediary Certificates

```
mkdir /root/ca/intermediate
```

```
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
```

Move config file:

`cp intermediate_ca_openssl.cnf /root/ca/openssl.cnf`

Further info on web or [here](./security/CertificateAuth/Further_info_on_config.md)

### Create the intermediate key

```
cd /root/ca
openssl genrsa -aes256 \
    -out intermediate/private/intermediate.key.pem 4096
```

> Enter pass phrase for intermediate.key.pem: secretpassword
> Verifying - Enter pass phrase for intermediate.key.pem: secretpassword

```
chmod 400 intermediate/private/intermediate.key.pem
```

### Create the intermediate certificate request

```
cd /root/ca
openssl req -config intermediate/openssl.cnf -new -sha256 \
    -key intermediate/private/intermediate.key.pem \
    -out intermediate/csr/intermediate.csr.pem
```

> Enter pass phrase for intermediate.key.pem: secretpassword
> You are about to be asked to enter information that will be incorporated
> into your certificate request.
> -----
> Country Name (2 letter code) [XX]:GB
> State or Province Name []:England
> Locality Name []:
> Organization Name []:Alice Ltd
> Organizational Unit Name []:Alice Ltd Certificate Authority
> Common Name []:Alice Ltd Intermediate CA
> Email Address []:

### Create the intermediate certificate from request

```
cd /root/ca
openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
    -days 3650 -notext -md sha256 \
    -in intermediate/csr/intermediate.csr.pem \
    -out intermediate/certs/intermediate.cert.pem
```

> Enter pass phrase for ca.key.pem: secretpassword
> Sign the certificate? [y/n]: y

```
chmod 444 intermediate/certs/intermediate.cert.pem
```

Now the `index.txt` has been updated for the tracking of the certificates.

> V 250408122707Z 1000 unknown ... /CN=Alice Ltd Intermediate CA

### Verify the intermediate certificate

```
openssl x509 -noout -text \
    -in intermediate/certs/intermediate.cert.pem
```

Check trust

```
openssl verify -CAfile certs/ca.cert.pem \
    intermediate/certs/intermediate.cert.pem
```

> intermediate.cert.pem: OK

### Create the certificate chain file

```
cat intermediate/certs/intermediate.cert.pem \
    certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
chmod 444 intermediate/certs/ca-chain.cert.pem
```

## Server and Client Certificates

### Create a key

```
# cd /root/ca
# openssl genrsa -aes256 \
      -out intermediate/private/www.example.com.key.pem 2048
# chmod 400 intermediate/private/www.example.com.key.pem
```

### Create a certificate request

```
cd /root/ca
openssl req -config intermediate/openssl.cnf \
    -key intermediate/private/www.example.com.key.pem \
    -new -sha256 -out intermediate/csr/www.example.com.csr.pem
```

> Enter pass phrase for www.example.com.key.pem: secretpassword
> You are about to be asked to enter information that will be incorporated
> into your certificate request.
> -----
> Country Name (2 letter code) [XX]:US
> State or Province Name []:California
> Locality Name []:Mountain View
> Organization Name []:Alice Ltd
> Organizational Unit Name []:Alice Ltd Web Services
> Common Name []:www.example.com
> Email Address []:

### Create a certificate from request

```
# cd /root/ca
# openssl ca -config intermediate/openssl.cnf \
      -extensions server_cert -days 375 -notext -md sha256 \
      -in intermediate/csr/www.example.com.csr.pem \
      -out intermediate/certs/www.example.com.cert.pem
# chmod 444 intermediate/certs/www.example.com.cert.pem
```

Now the `intermediate/index.txt` has been updated for the tracking of the certificates.

> V 160420124233Z 1000 unknown ... /CN=www.example.com

### Verify the intermediate certificate

```
openssl x509 -noout -text \
    -in intermediate/certs/www.example.com.cert.pem
```

Check trust

```
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
    intermediate/certs/www.example.com.cert.pem
```

> intermediate.cert.pem: OK

need to make the following files available:

* ca-chain.cert.pem (Needed for 3rd party)
* www.example.com.key.pem
* www.example.com.cert.pem (Needed for 3rd party)

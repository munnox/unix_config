# Certificate Authority

* Put a Cert Authority [here](./security/CertificateAuth/Create_Root_Inter_Certs.md)
* Sort the Certificate Revocation list [here](repo/unix_config/security/CertificateAuth/Cert_Revocation_List.md)

## Examples at client side

### Create

```
cd /home/bob
openssl genrsa -out bob@example.com.key.pem 2048
openssl req -new -key bob@example.com.key.pem \
    -out bob@example.com.csr.pem
```

> You are about to be asked to enter information that will be incorporated
> into your certificate request.
> -----
> Country Name [XX]:US
> State or Province Name []:California
> Locality Name []:San Francisco
> Organization Name []:Bob Ltd
> Organizational Unit Name []:
> Common Name []:bob@example.com
> Email Address []:

### Sign

```
cd /root/ca
openssl ca -config intermediate/openssl.cnf \
    -extensions usr_cert -notext -md sha256 \
    -in intermediate/csr/bob@example.com.csr.pem \
    -out intermediate/certs/bob@example.com.cert.pem
```

> Sign the certificate? [y/n]: y
> 1 out of 1 certificate requests certified, commit? [y/n]: y

Verify

```
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem \
    intermediate/certs/bob@example.com.cert.pem
```

> bob@example.com.cert.pem: OK

### Revoke

```
cd /root/ca
openssl ca -config intermediate/openssl.cnf \
    -revoke intermediate/certs/bob@example.com.cert.pem
```

> Enter pass phrase for intermediate.key.pem: secretpassword
> Revoking Certificate 1001.
> Data Base Updated

# Create a Certificate Authority

## Config

Add folowing to the cnf file so the link points to the `*.crt.pem`

```
[ server_cert ]
# ... snipped ...
crlDistributionPoints = URI:http://example.com/intermediate.crl.pem
```

### Create the CRL

```
cd /root/ca
openssl ca -config intermediate/openssl.cnf \
    -gencrl -out intermediate/crl/intermediate.crl.pem
```

> The CRL OPTIONS section of the ca man page contains more information on how to create CRLs.

Check CRL

```
openssl crl -in intermediate/crl/intermediate.crl.pem -noout -text
```

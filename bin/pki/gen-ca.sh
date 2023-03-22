#!/bin/bash
#
# Use once to generate the ca
#

DIR=../../pki/certs
mkdir -p $DIR

cat > $DIR/root-ca-csr.json <<EOF
{
  "key": {
    "algo": "rsa",
    "size": 4096
  },
  "names": [
    {
      "O": "socozy",
      "OU": "SoCozy Security",
      "L": "San Francisco",
      "ST": "California",
      "C": "USA"
    }
  ],
  "CN": "svc.socozy.casa"
}
EOF
cfssl gencert --initca=true $DIR/root-ca-csr.json | cfssljson --bare $DIR/root-ca

# verify
openssl x509 -in $DIR/root-ca.pem -text -noout


# cert-generation configuration
cat > $DIR/gencert.json <<EOF
{
  "signing": {
    "default": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
        "expiry": "87600h"
    }
  }
}
EOF

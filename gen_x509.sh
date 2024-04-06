#!/bin/bash

DOMAIN=$1
ROOT_CA=$2

ROOT_CRT=
ROOT_KEY=

if [[ -z "${ROOT_CA}" ]]; then
    ROOT_CRT=rootCA.crt
    ROOT_KEY=rootCA.key
    openssl genrsa -out $ROOT_KEY 2048
    openssl req -x509 -sha256 -new -nodes -key $ROOT_KEY -days 36500 -out $ROOT_CRT
  else
    ROOT_CRT="$ROOT_CA.crt"
    ROOT_KEY="$ROOT_CA.key"
fi

openssl genrsa -out "$DOMAIN.key" 2048

openssl req -new -sha256 \
    -key "$DOMAIN.key" \
    -subj "/C=US/ST=North Carolina/O=ORG/OU=ORG_UNIT/CN=$DOMAIN" \
    -reqexts SAN \
    -config <(cat /etc/ssl/openssl.cnf <(printf "\n[SAN]\nsubjectAltName=DNS:$DOMAIN")) \
    -out "$DOMAIN.csr"

openssl x509 -req -extfile <(printf "subjectAltName=DNS:$DOMAIN") -days 36500 -in $DOMAIN.csr -CA $ROOT_CRT -CAkey $ROOT_KEY -CAcreateserial -out $DOMAIN.crt -sha256
openssl dhparam -out dhparam.pem 4096

mkdir "$DOMAIN"

mv "$DOMAIN.key" "$DOMAIN"
mv "$DOMAIN.csr" "$DOMAIN"
mv "$DOMAIN.crt" "$DOMAIN"
mv dhparam.pem "$DOMAIN"

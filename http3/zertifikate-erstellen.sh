#!/bin/bash

set -xeu

# CA Zertifikate generieren
openssl ecparam -genkey -name prime256v1 -out ca-key.pem
openssl req -x509 -new -nodes -key ca-key.pem -sha256 -days 3650 -out ca-cert.pem -subj "/C=DE/ST=Test/L=Test/O=Test CA/CN=Test Local Root CA"

# Zertifikatsanfrage erstellen
openssl ecparam -genkey -name prime256v1 -out test.local-key.pem
openssl req -new -key test.local-key.pem -out test.local.csr -subj "/C=DE/ST=Test/L=Test/O=Test Local/CN=test.local"

# Anfrage signieren
openssl x509 -req -in test.local.csr -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out test.local-cert.pem -days 365 -sha256 -extfile test.local.ext
# Prüfsumme erzeugen
checksum=$(openssl x509 -pubkey -noout -in test.local-cert.pem | openssl ec -pubin -outform der | openssl dgst -sha256 -binary | base64)

sed -i -e s/--ignore-certificate-errors-spki-list=.*/--ignore-certificate-errors-spki-list=$checksum/ chrome-starten.sh

#!/bin/bash
set -euo pipefail

# Setting Variables
CA_DOMAIN="icurfer.com"
TARGET_DOMAIN="demo.test"
CERTS_DIR="${HOME}/certs"

# Create Directory
mkdir -p "$CERTS_DIR"
cd "$CERTS_DIR"

# 1. Create CA key (4096 bit)
openssl genrsa -out ca.key 4096

# 2. Create CA cert (10 years)
openssl req -x509 -new -nodes -sha512 -days 3650 \
  -subj "/C=KR/ST=Seoul/L=Seoul/O=icurfer/OU=IT/CN=${CA_DOMAIN}" \
  -key ca.key -out ca.crt

# 3. Create Server key (4096 bit)
openssl genrsa -out "${TARGET_DOMAIN}.key" 4096

# 4. Create Server CSR (Certificate Signing Request)
openssl req -sha512 -new \
  -subj "/C=KR/ST=Seoul/L=Seoul/O=icurfer/OU=IT/CN=${TARGET_DOMAIN}" \
  -key "${TARGET_DOMAIN}.key" -out "${TARGET_DOMAIN}.csr"

# 5. Create x509 v3 extension file (wildcard included)
cat > v3.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=${TARGET_DOMAIN}
DNS.2=*.${TARGET_DOMAIN}
EOF

# 6. Create Server cert (10 years, include SAN)
openssl x509 -req -sha512 -days 3650 -extfile v3.ext \
  -CA ca.crt -CAkey ca.key -CAcreateserial \
  -in "${TARGET_DOMAIN}.csr" -out "${TARGET_DOMAIN}.crt"

# 7. RSA conversion
openssl pkey -in "${TARGET_DOMAIN}.key" \
  -out "${TARGET_DOMAIN}.rsa.key" -traditional

# 8. Print result after every command succeeds
echo "CA cert: ${CERTS_DIR}/ca.crt"
echo "Server key: ${CERTS_DIR}/${TARGET_DOMAIN}.key"
echo "Server CSR: ${CERTS_DIR}/${TARGET_DOMAIN}.csr"
echo "Server cert: ${CERTS_DIR}/${TARGET_DOMAIN}.crt"
echo "Server RSA key: ${CERTS_DIR}/${TARGET_DOMAIN}.rsa.key"
echo "Create Success All Certificate"

#!/bin/bash

set -e

CERTS_DIR="./certs"

echo "📁 Creating certificates directory: $CERTS_DIR"
mkdir -p "$CERTS_DIR"
cd "$CERTS_DIR"

echo "🔑 Generating private key..."
openssl genrsa -out server.key 2048

echo "📄 Generating self-signed certificate..."
openssl req -new -x509 -key server.key -out server.crt -days 365 \
  -subj "/CN=postgres.local"

echo "📄 Creating CA (copying certificate)..."
cp server.crt ca.crt

echo "🔐 Setting permissions..."
chmod 600 server.key
chmod 644 server.crt ca.crt

echo "✅ Certificates generated in: $CERTS_DIR"
ls -l "$CERTS_DIR"

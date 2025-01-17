#!/usr/bin/env bash
set -Eeuo pipefail
touch /var/lib/gvm/.ssh/authorized_keys
chmod 600 /var/lib/gvm/.ssh/authorized_keys

read -p "Scanner Name: " SCANNER_NAME
read -p "Scanner ID: " SCANNER_ID
read -p "Scanner public key: " SCANNER_KEY

echo "Adding scanner $SCANNER_NAME..."

su -c "gvmd --create-scanner='$SCANNER_NAME' --scanner-type=OpenVAS --scanner-host='/sockets/$SCANNER_ID.sock'" gvm

echo "${SCANNER_KEY}" >>/var/lib/gvm/.ssh/authorized_keys
chown gvm:gvm -R /var/lib/gvm/.ssh

#!/bin/bash -eux

echo "==> Replace MateriApps LIVE! gpg key"
apt-get -y install --no-install-recommends materiapps-keyring
rm -f /etc/apt/trusted.gpg

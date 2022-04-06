#!/bin/bash -eux

echo "==> Install xterm"
apt-get -y install --no-install-recommends xterm

echo "==> Remove XTerm and UXTerm from menu"
rm -f /usr/share/applications/debian-uxterm.desktop /usr/share/applications/debian-xterm.desktop

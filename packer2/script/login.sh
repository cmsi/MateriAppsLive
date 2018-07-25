#!/bin/sh

echo "==> Replacing lightdm login background"

mkdir -p /etc/malive
chmod 755 /etc/malive
cp /tmp/login.svg /etc/malive/login.svg
chmod 644 /etc/malive/login.svg
rm -f /tmp.login.svg

sed -i s@#background=@background=/etc/malive/login.svg@ /etc/lightdm/lightdm-gtk-greeter.conf

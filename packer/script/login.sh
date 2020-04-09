#!/bin/sh

echo "==> Replacing lightdm login background"
DEBIAN_VERSION=$(cut -d. -f 1 /etc/debian_version)

mkdir -p /etc/malive
chmod 755 /etc/malive
cp /tmp/files/login${DEBIAN_VERSION}.svg /etc/malive/login.svg
chmod 644 /etc/malive/login.svg

cp -fp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.orig
sed -i s@#background=@background=/etc/malive/login.svg@ /etc/lightdm/lightdm-gtk-greeter.conf

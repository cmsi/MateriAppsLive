#!/bin/sh

echo "==> Replacing lightdm login background"

mkdir -p /etc/malive
chmod 755 /etc/malive
cp /tmp/files/login-ce5.svg /etc/malive/login.svg
chmod 644 /etc/malive/login.svg

cp -fp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.orig
sed -i s@#background=@background=/etc/malive/login.svg@ /etc/lightdm/lightdm-gtk-greeter.conf

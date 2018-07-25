#!/bin/sh

echo "==> Replacing lxde menu"

mv -f /etc/xdg/menus/lxde-applications.menu /etc/xdg/menus/lxde-applications.menu.orig
cp /tmp/files/lxde-applications.menu /etc/xdg/menus
chmod 644 /etc/xdg/menus/lxde-applications.menu

FILES="database.directory materiapps.directory"
for f in $FILES; do
  cp /tmp/files/$f /usr/share/desktop-directories/
  chmod 644 /usr/share/desktop-directories/$f
fi

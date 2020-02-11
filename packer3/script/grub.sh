#!/bin/sh

echo "==> Updating grub setup"

sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/ /etc/default/grub
update-grub

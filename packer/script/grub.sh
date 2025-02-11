#!/bin/sh

echo "==> Updating grub setup & fix EFI filepath"

sed -i s/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/ /etc/default/grub
update-grub

mkdir -p /boot/efi/EFI/boot
if [ -f /boot/efi/EFI/debian/grubx64.efi ]; then
    cp /boot/efi/EFI/debian/grubx64.efi /boot/efi/EFI/boot/bootx64.efi
fi
if [ -f /boot/efi/EFI/debian/grubaa64.efi ]; then
    cp /boot/efi/EFI/debian/grubaa64.efi /boot/efi/EFI/boot/bootaa64.efi
fi

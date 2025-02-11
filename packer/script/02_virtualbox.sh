#!/bin/bash -eux

echo "==> Installing VirtualBox guest additions"
apt-get -y install --no-install-recommends linux-headers-$(uname -r) dkms build-essential perl

mount -o loop /home/user/VBoxGuestAdditions.iso /mnt
ARCH=$(arch)
if [ "$ARCH" = "x86_64" ]; then
  sh /mnt/VBoxLinuxAdditions.run --nox11
fi
if [ "$ARCH" = "aarch64" ]; then
  sh /mnt/VBoxLinuxAdditions-arm64.run --nox11
fi
umount /mnt
rm /home/user/VBoxGuestAdditions.iso
rm /home/user/.vbox_version

usermod -G vboxsf -a user

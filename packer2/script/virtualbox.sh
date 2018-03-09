#!/bin/bash -eux

echo "==> Installing VirtualBox guest additions"
apt install -y linux-headers-$(uname -r) linux-headers-$(dpkg --print-architecture) dkms build-essential perl

mount -o loop /home/user/VBoxGuestAdditions.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm /home/user/VBoxGuestAdditions.iso
rm /home/user/.vbox_version

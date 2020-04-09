#!/bin/bash -eux

echo "==> Installing VirtualBox guest additions"
apt-get -y install linux-headers-$(uname -r) dkms build-essential perl

mount -o loop /home/user/VBoxGuestAdditions.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm /home/user/VBoxGuestAdditions.iso
rm /home/user/.vbox_version

usermod -G vboxsf -a user

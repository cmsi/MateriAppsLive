#!/bin/bash -eux

echo "==> Disk usage before minimization"
df -h

echo "==> Removing all linux kernels except the currrent one"
dpkg --list | awk '{ print $2 }' | grep 'linux-image-4' | grep -v $(uname -r) | xargs apt-get -y purge
echo "==> Removing linux headers"
dpkg --list | awk '{ print $2 }' | grep linux-headers | xargs apt-get -y purge
rm -rf /usr/src/linux-headers*
echo "==> Removing linux source"
dpkg --list | awk '{ print $2 }' | grep linux-source | xargs apt-get -y purge
echo "==> Removing obsolete networking components"
apt-get -y purge ppp pppconfig pppoeconf
echo "==> Removing other oddities"
apt-get -y purge popularity-contest installation-report wireless-tools wpasupplicant

echo "==> Removing visual tools"
apt-get -y purge lxmusic mpv pulseaudio libpulse0 youtube-dl
echo "==> Removing clipit xterm gksu deluge"
apt-get -y purge clipit xterm gksu deluge

# Clean up the apt cache
echo "==> Cleaning up the apt cache"
apt-get -y autoremove --purge
apt-get -y autoclean
apt-get -y clean

echo "==> Removing caches"
find /var/cache -type f -delete
echo "==> Removing groff info lintian linda"
rm -rf /usr/share/groff/* /usr/share/info/* /usr/share/lintian/* /usr/share/linda/*

echo "==> Disk usage after cleanup"
df -h

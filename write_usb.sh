#!/bin/sh

# This utility is based on Mathlibre mkusbmath tool
# https://github.com/knxm/mathlibre/blob/master/config/includes.chroot/usr/sbin/mkusbmath

IMAGE="$1"
DEV="$2"
if [ -z "$DEV" ]; then
  echo "Usage: $0 image device"
  exit 127
fi
if [ -f "$IMAGE" ]; then :; else
  echo "Error: image file not found ($IMAGE)"
  exit 127
fi

echo "Info: source image = $IMAGE"
echo "Info: target device = $DEV"

NUM="1 2 3 4 5 6 7 8"
for n in $NUM; do
  r=`(df | grep $DEV$n > /dev/null 2>&1); echo $?`
  if [ $r = "0" ]; then
    echo "Info: umounting $DEV$n"
    umount $DEV$n
  fi
done

SIZE=`du -sb $IMAGE | awk '{print $1}'`
echo "Info: image size = $SIZE B"
echo "Info: start writing MateriApps LIVE! image"
bar -if $IMAGE -of $DEV -bs 4M -s $SIZE

echo "Info: making persistent partition"
END=$(parted $DEV unit s print | grep boot | cut -d 's' -f 2)
MIN=$(expr $END + 1)
echo "Info: making persistent partition on ${DEV}2"
parted --align=min $DEV unit s mkpart primary ext4 $MIN 100%
echo "Info: formatting ${DEV}2"
mkfs.ext4 ${DEV}2 -L persistence
mkdir -p /mnt/tmp
mount ${DEV}2 /mnt/tmp
echo "/ union" > /mnt/tmp/live-persistence.conf
sync;sync;sync
umount /mnt/tmp
parted $DEV print

echo "Info: done"

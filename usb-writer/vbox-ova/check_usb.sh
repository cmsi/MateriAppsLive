#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/devices.sh

MNT="/mnt/write_vb.$$"
n=1
for d in $DEV; do
  if [ -b /dev/$d ]; then
    mkdir -p $MNT
    mount /dev/$d$n $MNT
    if test -f "$MNT/MD5SUM-checked"; then
      echo "/dev/$d O"
    else
      echo "/dev/$d X"
    fi
    umount $MNT
  else
    echo "/dev/$d -"
  fi
done

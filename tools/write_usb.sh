#!/bin/sh

MD5="MD5SUM"
DEV="$1"
MNT="/mnt/write_vb.$$"

if [ -z "$DEV" ]; then
  echo "Usage: $0 device"
  exit 127
fi
if [ -f "$MD5" ]; then :; else
  echo "Error: md5 file ($MD5) not found"
  exit 127
fi
if [ -b "$DEV" ]; then :; else
  echo "Error: $DEV not exist"
  exit 127
fi

echo "Info: md5 file = $MD5"
echo "Info: target device = $DEV"

# unmount and make partition
NUM="1 2 3 4 5 6 7 8"
for n in $NUM; do
  r=`(df | grep $DEV$n > /dev/null 2>&1); echo $?`
  if [ $r = "0" ]; then
    echo "Info: umounting $DEV$n"
    umount $DEV$n
  fi
done
for n in $NUM; do
  echo "Info: removing $DEV$n"
  parted $DEV rm $n > /dev/null 2>&1
done
n=1
echo "Info: making $DEV$n and mounting filesystem"
parted --align=min $DEV mkpart primary fat32 0% 100%
mkfs.vfat $DEV$n -n "MateriApps"

# copy files
mkdir -p $MNT
mount $DEV$n $MNT
FILES=$(awk '{print $3}' $MD5)
for f in $FILES $MD5; do
  echo "Info: copying $f..."
  cp -fp $f $MNT
done
sync; sync; sync; umount $DEV$n

# check
mount $DEV$n $MNT
for f in $FILES; do
  md5_in=$(grep $f $MD5 | awk '{print $1}')
  size_in=$(ls -l $f | awk '{print $5}')
  md5_out=$(md5sum $MNT/$f | awk '{print $1}')
  size_out=$(ls -l $MNT/$f | awk '{print $5}')
  if [ $md5_out != $md5_in ]; then
    echo "Error: checksum error for $f"
  elif [ $size_out != $size_in ]; then
    echo "Error: size check error for $f"
  else
    echo "Info: checksum test passed for $f"
  fi  
done
sync; sync; sync; umount $DEV$n

rm -rf $MNT
exit 0

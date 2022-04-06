#!/bin/sh

MD5="MD5SUM"
rm -f $MD5
FILES=$(ls)
if [ -x /sbin/md5 ]; then
  for f in $FILES; do
    if [ -f $f ]; then
      printf "%s %11d %s\n" $(md5 $f | awk '{print $4}') $(ls -l $f | awk '{print $5}') $(basename $f) >> $MD5
    fi
  done
else
  for f in $FILES; do
    if [ -f $f ]; then
      printf "%s %11d %s\n" $(md5sum $f | awk '{print $1}') $(ls -l $f | awk '{print $5}') $(basename $f) >> $MD5
    fi
  done
fi
cat $MD5

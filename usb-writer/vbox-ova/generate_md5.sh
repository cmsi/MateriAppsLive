#!/bin/sh

MD5="MD5SUM"
rm -f $MD5
FILES=$(ls)
for f in $FILES; do
  if [ -f $f ]; then
    printf "%s %11d %s\n" $(md5sum $f | awk '{print $1}') $(ls -l $f | awk '{print $5}') $(basename $f) >> $MD5
  fi
done
cat $MD5

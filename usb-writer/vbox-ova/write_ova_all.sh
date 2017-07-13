#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/devices.sh

date

for d in $DEV; do
  if [ -b /dev/$d ]; then
    sh $SCRIPT_DIR/write_ova.sh /dev/$d &
  fi
done
wait

date

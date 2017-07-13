#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
. $SCRIPT_DIR/devices.sh

for d in $DEV; do
  if [ -b /dev/$d ]; then
    echo "/dev/$d O"
  else
    echo "/dev/$d X"
  fi
done

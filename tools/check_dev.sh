#!/bin/sh

DEV="sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr"

for d in $DEV; do
  if [ -b /dev/$d ]; then
    echo "/dev/$d O"
  else
    echo "/dev/$d X"
  fi
done
wait


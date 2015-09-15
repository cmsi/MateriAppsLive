DEV="sdc sdd sde sdf sdg sdh sdi sdj sdk sdl sdm sdn sdo sdp sdq sdr"
SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)

date

for d in $DEV; do
  if [ -b /dev/$d ]; then
    sh $SCRIPT_DIR/write_ova.sh /dev/$d &
  fi
done
wait

date

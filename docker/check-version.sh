#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"
. $SCRIPT_DIR/../config/version.sh
CODENAME=""
for v in ${DEBIAN_VERSIONS}; do
  CODENAMES="${CODENAMES} $(echo ${v} | cut -d/ -f1)"
done

for c in ${CODENAMES}; do
  echo "checking for ${c}..."
  IMAGE="madev/${c}"
  docker run --rm --name ${c}.$$ ${IMAGE} lsb_release -s -c
  docker run --rm --name ${c}.$$ ${IMAGE} gcc --version | head -1
done

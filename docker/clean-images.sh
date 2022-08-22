#!/bin/sh

CODENAMES="$1"

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../version.sh
if [ -z ${CODENAMES} ]; then
  for v in ${DEBIAN_VERSIONS}; do
    CODENAMES="${CODENAMES} $(echo ${v} | cut -d/ -f1)"
  done
fi

for c in ${CODENAMES}; do
  echo "removing image ${IMAGE}..."
  docker rmi madev/${c}
done
docker volume prune -f
docker system prune -f
docker images
docker system df

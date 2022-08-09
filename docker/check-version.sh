#!/bin/sh

. ./version.sh
CODENAME=""
for v in ${VERSIONS}; do
  CODENAMES="${CODENAMES} $(echo ${v} | cut -d/ -f1)"
done

for c in ${CODENAMES}; do
  echo "checking for ${c}..."
  IMAGE="madev/${c}"
  docker run --rm --name ${c}.$$ ${IMAGE} lsb_release -s -c
  docker run --rm --name ${c}.$$ ${IMAGE} gcc --version | head -1
done

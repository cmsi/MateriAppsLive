#!/bin/sh

CODENAMES="$1"

. version.sh
if [ -z ${CODENAMES} ]; then
  for v in ${VERSIONS}; do
    CODENAMES="${CODENAMES} $(echo ${v} | cut -d/ -f1)"
  done
fi

for c in ${CODENAMES}; do
  echo "removing image ${IMAGE}..."
  docker rmi madev/${c}
done
docker system prune -f
docker system df

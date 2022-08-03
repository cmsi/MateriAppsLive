#!/bin/sh

VERSIONS="$1"

if [ -z ${VERSIONS} ]; then
  VERSIONS="bullseye buster jammy focal bionic"
fi

for v in ${VERSIONS}; do
  echo "removing image malive/${v}..."
  docker rmi malive/${v}
  echo "building image for ${v}..."
  docker build -t malive/${v} -f ${v}/Dockerfile .
done
docker images

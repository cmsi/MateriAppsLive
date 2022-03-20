#!/bin/sh

VERSIONS="$1"

if [ -z ${VERSIONS} ]; then
  VERSIONS="bullseye buster stretch jammy focal bionic"
fi

for v in ${VERSIONS}; do
  echo "building image for ${v}..."
  IMAGE="malive/${v}"
  docker build -t ${IMAGE} -f ${v}/Dockerfile .
done
docker images

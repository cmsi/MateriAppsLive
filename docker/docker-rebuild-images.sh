#!/bin/sh

VERSIONS="$1"

if [ -z ${VERSIONS} ]; then
  VERSIONS="bullseye buster jammy focal bionic"
fi

make

for v in ${VERSIONS}; do
  if [ -d ${v} ]; then
    echo "building image for ${v}..."
    IMAGE="malive/${v}"
    docker rmi ${IMAGE}
    docker build --no-cache=true -t ${IMAGE} -f ${v}/Dockerfile .
  fi
done
docker images

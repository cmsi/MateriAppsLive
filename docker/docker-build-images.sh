#!/bin/sh

DIRS="$(find . -name Dockerfile)"
for d in ${DIRS}; do
  VERSION="$(basename $(dirname ${d}))"
  echo "building image for ${VERSION}..."
  IMAGE="malive/${VERSION}"
  docker build -t ${IMAGE} -f ${VERSION}/Dockerfile .
done
docker images

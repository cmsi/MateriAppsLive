#!/bin/sh

DIRS="$(find . -name Dockerfile)"
for d in ${DIRS}; do
  VERSIONS="${VERSIONS} $(basename $(dirname ${d}))"
done

for v in ${VERSIONS}; do
  echo "checking for ${v}..."
  IMAGE="malive/${v}"
  set -x
  docker run --rm --name ${v} ${IMAGE} lsb_release -s -c
  set +x
done

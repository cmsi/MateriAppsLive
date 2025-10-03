#!/bin/bash -eux

NAMES="ma4 ma5 ma6 ce4 ce5 ce6"
for name in $NAMES; do
  script="build-upload-image-${name}.sh"
  if [ -f "${script}" ]; then
    echo "Running ${script}"
    sh "${script}"
  fi
done

#!/bin/bash -eux

SCRIPTS="build-ma3.sh build-ce3.sh"
for script in $SCRIPTS; do
  if [ -f ${script} ]; then
    sh ${script}
  fi
done

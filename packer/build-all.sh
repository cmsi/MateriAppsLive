#!/bin/bash -eux

SCRIPTS="build-ma4.sh build-ce4.sh"
for script in $SCRIPTS; do
  if [ -f ${script} ]; then
    sh ${script}
  fi
done

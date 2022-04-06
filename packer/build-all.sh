#!/bin/bash -eux

SCRIPTS="build-ma3.sh build-ce3.sh build-ma4.sh build-ce4.sh"
for script in $SCRIPTS; do
  if [ -f ${script} ]; then
    sh ${script}
  fi
done

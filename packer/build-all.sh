#!/bin/bash -eux

SCRIPTS="build-ma4.sh build-ma5.sh build-ce4.sh build-ce5.sh"
for script in $SCRIPTS; do
  if [ -f ${script} ]; then
    sh ${script}
  fi
done

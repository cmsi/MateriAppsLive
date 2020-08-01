#!/bin/bash -eu

echo "==> Check Installed MateriApps Packages/Tools"

COMMANDS="c-tools fermisurfer gamess-setup new_bfss ovito pconfig vmd-setup"
for c in $COMMANDS; do
  echo -n "$c: "
  type $c > /dev/null 2>&1 && echo "OK" || echo "Error"
done

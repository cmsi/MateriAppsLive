#!/bin/bash -eu

echo "==> Check Installed Packages/Tools"

echo -n "Python3: "
python3 -c "import numpy; import scipy; import sympy" > /dev/null 2>&1 && echo "OK" || echo "Error"

COMMANDS="evince pip3"
for c in $COMMANDS; do
  echo -n "$c: "
  type $c > /dev/null 2>&1 && echo "OK" || echo "Error"
done

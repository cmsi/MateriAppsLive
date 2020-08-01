#!/bin/bash -eu

echo "==> Check Installed Packages/Tools"

echo -n "Python2: "
python2 -c "import numpy; import scipy; import matplotlib; import sympy" > /dev/null 2>&1 && echo "OK" || echo "Error"

echo -n "Python3: "
python3 -c "import numpy; import scipy; import matplotlib; import sympy" > /dev/null 2>&1 && echo "OK" || echo "Error"

COMMANDS="evince pip2 pip3"
for c in $COMMANDS; do
  echo -n "$c: "
  type $c > /dev/null 2>&1 && echo "OK" || echo "Error"
done

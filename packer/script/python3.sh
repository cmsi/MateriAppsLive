#!/bin/bash -eux

echo "==> Install Python modules"
apt-get -y install --no-install-recommends python3-pip \
	python3-venv \
	jupyter-notebook \
	python3-numpy python3-scipy python3-matplotlib python3-tk \
	python3-sympy \
	python3-dev

# ipython
echo "==> Install iPython"
apt-get -y install --no-install-recommends ipython3

# /usr/local/lib/python3
VERSION=$(python3 --version 2>&1 | cut -d' ' -f 2 | cut -d. -f 1,2)
mkdir -p /usr/local/lib/python$VERSION
ln -s python$VERSION /usr/local/lib/python3

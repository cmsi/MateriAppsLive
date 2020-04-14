#!/bin/bash -eux

echo "==> Install Python modules"
apt-get -y install --no-install-recommends python-pip python3-pip \
	python-virtualenv python3-venv \
	python-notebook jupyter-notebook \
	python-numpy python-scipy python-matplotlib python3-numpy python3-scipy python3-matplotlib \
	python-sympy python3-sympy

# jupyter
cat << EOF > /usr/local/bin/jupyter
#!/usr/bin/python3
from jupyter_core.command import main
if __name__ == '__main__':
    main()
EOF
chmod +x /usr/local/bin/jupyter

# ipython
echo "==> Install iPython"
apt-get -y install --no-install-recommends ipython ipython3
ln -s /usr/bin/ipython /usr/local/bin/ipython2

# /usr/local/lib/python2
VERSION=$(python2 --version 2>&1 | cut -d' ' -f 2 | cut -d. -f 1,2)
mkdir -p /usr/local/lib/python$VERSION
ln -s python$VERSION /usr/local/lib/python2

# /usr/local/lib/python3
VERSION=$(python3 --version 2>&1 | cut -d' ' -f 2 | cut -d. -f 1,2)
mkdir -p /usr/local/lib/python$VERSION
ln -s python$VERSION /usr/local/lib/python3

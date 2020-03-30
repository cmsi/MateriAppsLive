#!/bin/bash -eux

echo "==> Install Python modules"
apt-get -y install python-pip python3-pip
apt-get -y install python-virtualenv python3-venv
apt-get -y install python-notebook jupyter-notebook
apt-get -y install python-numpy python-scipy python-matplotlib python3-numpy python3-scipy python3-matplotlib
apt-get -y install python-sympy python3-sympy

# jupyter
cat << EOF > /usr/local/bin/jupyter
#!/usr/bin/python3
from jupyter_core.command import main
if __name__ == '__main__':
    main()
EOF
chmod +x /usr/local/bin/jupyter

# ipython
apt-get -y install ipython ipython3
ln -s /usr/bin/ipython /usr/local/bin/ipython2

# /usr/local/lib/python2
VERSION=$(python2 --version 2>&1 | cut -d' ' -f 2 | cut -d. -f 1,2)
mkdir -p /usr/local/lib/python$VERSION
ln -s python$VERSION /usr/local/lib/python2

# /usr/local/lib/python3
VERSION=$(python3 --version 2>&1 | cut -d' ' -f 2 | cut -d. -f 1,2)
mkdir -p /usr/local/lib/python$VERSION
ln -s python$VERSION /usr/local/lib/python3

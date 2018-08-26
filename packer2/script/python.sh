#!/bin/bash -eux

echo "==> Install Python modules"
apt-get -y install python-pip python3-pip
apt-get -y install python-virtualenv python3-venv
apt-get -y install python-notebook jupyter-notebook
apt-get -y install python-numpy python-scipy python-matplotlib python3-numpy python3-scipy python3-matplotlib

# jupyter
cat << EOF > /usr/local/bin/jupyter
#!/usr/bin/python3
from jupyter_core.command import main
if __name__ == '__main__':
    main()
EOF
chmod +x /usr/local/bin/jupyter

# ipython2
ln -s /usr/bin/ipython /usr/local/bin/ipython2

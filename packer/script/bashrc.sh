#!/bin/bash -eux

echo "==> Switch off screensaver"
cat << EOF >> /etc/bash.bashrc

# switch of screensaver
xset s 0 0
EOF

echo "==> Include \$HOME/bin in \$PATH"
cat << EOF >> /etc/bash.bashrc

# include \$HOME/bin in \$PATH
export PATH=\$HOME/bin:\$PATH
EOF

echo "==> Set default OMP_NUM_THREADS to 1"
cat << EOF >> /etc/bash.bashrc

# set default OMP_NUM_THREADS to 1
export OMP_NUM_THREADS=1
EOF

echo "==> Switch off color prompt"
sed -i -e s/color_prompt=yes/color_prompt=no/ /etc/skel/.bashrc
cp /etc/skel/.bashrc $HOME
chown user.user $HOME/.bashrc

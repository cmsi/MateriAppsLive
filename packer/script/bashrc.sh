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

echo "==> Switch off color prompt"
sed -i -e s/color_prompt=yes/color_prompt=no/ /etc/skel/.bashrc
cp /etc/skel/.bashrc $HOME
chown user.user $HOME/.bashrc

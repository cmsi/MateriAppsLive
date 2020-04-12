#!/bin/bash -eux

echo "==> Include \$HOME/bin in \$PATH"
cat << EOF >> /etc/bash.bashrc
export PATH=\$HOME/bin:\$PATH
EOF

echo "==> Switch off color prompt"
sed -i -e s/color_prompt=yes/color_prompt=no/ /etc/skel/.bashrc
cp /etc/skel/.bashrc $HOME
chown user.user $HOME/.bashrc

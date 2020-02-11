#!/bin/bash -eux

echo "==> Include \$HOME/bin in \$PATH"
cat << EOF >> /etc/bash.bashrc
export PATH=\$HOME/bin:\$PATH
EOF

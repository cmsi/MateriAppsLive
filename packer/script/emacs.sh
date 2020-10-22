#!/bin/bash -eux

echo "==> Setup emacs init file"
mkdir -p $HOME/.emacs.d
cat << EOF > $HOME/.emacs.d/init.el
(setq inhibit-startup-screen t)
(setq default-frame-alist '((height . 28)))
EOF
chown -R user.user $HOME/.emacs.d

#!/bin/bash -eux

echo "==> Install ceenv package"
apt-get -y install --no-install-recommends ceenv

echo "==> Copy desktop file(s)"
if [ -d /etc/skel/Desktop ]; then
  cp -frp /etc/skel/Desktop $HOME
fi
if [ -d /etc/skel/.config ]; then
  cp -frp /etc/skel/.config $HOME
fi
chown -R user.user $HOME/Desktop $HOME/.config

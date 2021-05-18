#!/bin/sh

USER=vagrant
mkdir -p /home/$USER/malive

rm -f /home/$USER/malive/development /home/$USER/malive/data
ln -s /development /home/$USER/malive/development
ln -s /data /home/$USER/malive/data
chown ${USER}.${USER} /home/$USER/malive/*

CONF=".bash_profile .devscripts .gbp.conf .quiltrc"
for c in $CONF; do
  rm -f /home/$USER/$c
  ln -s /development/MateriAppsLive/vagrant/dot$c /home/$USER/$c
  chown ${USER}.${USER} /home/$USER/$c
done

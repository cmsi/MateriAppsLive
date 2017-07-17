#!/bin/sh

VM="madev8-amd64"
for v in $VM; do
  cd $HOME/vagrant/$v
  vagrant ssh -c "sh development/MateriAppsLive/ova/update.sh"
done

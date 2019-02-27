#!/bin/sh

VM="madev9-amd64"
for v in $VM; do
  cd $HOME/vagrant/$v
  vagrant ssh -c "sh development/MateriAppsLive/ova/update.sh"
done

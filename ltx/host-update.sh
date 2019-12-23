#!/bin/sh

VM="madev10-amd64"
for v in $VM; do
  cd $HOME/vagrant/$v
  vagrant ssh -c "sh development/MateriAppsLive/ltx/update.sh"
done

#!/bin/sh

rm -f $HOME/development
ln -s /development $HOME/development

rm -f $HOME/data
ln -s /data $HOME/data

rm -f $HOME/.bash_profile
ln -s development/MateriAppsLive/vagrant/dot.bash_profile $HOME/.bash_profile

rm -f $HOME/.quiltrc
ln -s development/MateriAppsLive/vagrant/dot.quiltrc $HOME/.quiltrc

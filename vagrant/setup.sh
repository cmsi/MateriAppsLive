#!/bin/sh

rm -f $HOME/development
ln -s /development $HOME/development

rm -f $HOME/.bash_profile
ln -s $HOME/development/MateriAppsLive/vagrant/dot.bash_profile $HOME/.bash_profile

rm -f $HOME/.quiltrc
ln -s $HOME/development/MateriAppsLive/vagrant/dot.quiltrc $HOME/.quiltrc

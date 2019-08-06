#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127

VM="madev10-amd64"

cd $HOME/vagrant/$VM
vagrant ssh -c "sh development/MateriAppsLive/repos/add.sh $PACKAGE"

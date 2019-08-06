#!/bin/sh
PACKAGE="$1"
test -z $PACKAGE && exit 127

VM="madev10-amd64"
cd $HOME/vagrant/$VM
CODENAME="buster stretch jessie wheezy"
vagrant ssh -c "for cname in $CODENAME; do reprepro -Vb data/apt/\$cname list \$cname $PACKAGE; done"

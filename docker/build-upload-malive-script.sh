#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../version.sh
VERSION=${MA4_VERSION}

echo "generating malive script..."
sed -e "s|@MA4_VERSION@|${MA4_VERSION}|g" ${SCRIPT_DIR}/malive.in > malive
RSYNC="rsync -avzP --delete -e ssh"
$RSYNC malive root@exa:/var/www/html/archive/MateriApps/docker
$RSYNC malive frs.sourceforge.net:/home/frs/project/materiappslive/docker

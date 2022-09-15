#!/bin/sh

echo "uploading malive script..."
RSYNC="rsync -avzP --delete -e ssh"
$RSYNC malive root@exa:/var/www/html/archive/MateriApps/docker
$RSYNC malive frs.sourceforge.net:/home/frs/project/materiappslive/docker

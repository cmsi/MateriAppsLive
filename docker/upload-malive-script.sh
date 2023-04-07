#!/bin/sh

RSYNC="rsync -avzP --delete -e ssh"

# malive
echo "uploading malive script..."
${RSYNC} malive root@exa:/var/www/html/archive/MateriApps/docker
${RSYNC} malive frs.sourceforge.net:/home/frs/project/materiappslive/docker

# ceenv
echo "uploading ceenv script..."
${RSYNC} ceenv root@exa:/var/www/html/archive/MateriApps/docker
${RSYNC} ceenv frs.sourceforge.net:/home/frs/project/ceenv/docker

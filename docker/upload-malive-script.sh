#!/bin/sh

RSYNC="rsync -avzP --delete -e ssh"

# malive
echo "uploading malive script..."
${RSYNC} malive.sh root@exa:/var/www/html/archive/MateriApps/docker
${RSYNC} malive.sh frs.sourceforge.net:/home/frs/project/materiappslive/docker

# ceenv
echo "uploading ceenv script..."
${RSYNC} ceenv.sh root@exa:/var/www/html/archive/MateriApps/docker
${RSYNC} ceenv.sh frs.sourceforge.net:/home/frs/project/ceenv/docker

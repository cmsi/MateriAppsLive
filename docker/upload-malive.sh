#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../version.sh
CODENAMES=${MA4_CODENAME}
VERSION=${MA4_VERSION}

RSYNC="rsync -avzP --delete -e ssh"
$RSYNC malive root@${EXA}:/var/www/html/archive/MateriApps/docker
$RSYNC malive frs.sourceforge.net:/home/frs/project/materiappslive/docker

for c in ${CODENAMES}; do
  for v in ${DEBIAN_VERSIONS}; do
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="malive/malive:${VERSION}"
      echo "uploading image ${IMAGE}..."
      docker push ${IMAGE}
      docker tag ${IMAGE} "malive/malive:latest"
      echo "uploading image malive/malive:latest..."
      docker push malive/malive:latest
    fi
  done
done

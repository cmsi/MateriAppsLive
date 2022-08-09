#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)

IMAGE=malive
D_USERNAME=user
D_HOME=/home/${D_USERNAME}

if [ -d "${HOME}/share" ]; then
  SHARE_CONFIG="-v ${HOME}/share:${D_HOME}/share"
fi
if [ -f "${HOME}/.Xauthority" ]; then
  X_CONFIG="-e DISPLAY=$(hostname):0 -v ${HOME}/.Xauthority:${D_HOME}/.Xauthority"
fi


echo "starting ${IMAGE}"
ID_U=$(id -u)
ID_G=$(id -g)
set -x
docker run -it --name ${IMAGE}.$$ --user ${ID_U}:${ID_G} -v malive-vol:/home/user ${SHARE_CONFIG} ${X_CONFIG} ${IMAGE} /bin/bash

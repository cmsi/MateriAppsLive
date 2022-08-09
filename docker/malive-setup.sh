#!/bin/sh

BASE="malive/malive"
IMAGE="malive"

echo "building building image ${IMAGE} from ${BASE}..."
docker build -t ${IMAGE} - <<EOF
FROM ${BASE}
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=$(id -u)
ARG GID=$(id -g)
ARG PASSWORD=live
RUN groupadd -f -g \$GID \$GROUPNAME \
 && useradd -m -s /bin/bash -u \$UID -g \$GID -G sudo \$USERNAME \
 && echo \$USERNAME:\$PASSWORD | chpasswd \
 && echo "\$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER \$USERNAME
WORKDIR /home/\$USERNAME/
EOF

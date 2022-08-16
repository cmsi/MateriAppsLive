#!/bin/sh

CODENAMES="$1"

. ./version.sh
if [ -z ${CODENAMES} ]; then
  for v in ${VERSIONS}; do
    CODENAMES="${CODENAMES} $(echo ${v} | cut -d/ -f1)"
  done
fi

for c in ${CODENAMES}; do
  for v in ${VERSIONS}; do
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="madev/${c}"
      echo "building image ${IMAGE} from ${BASE}..."
      docker build -t ${IMAGE} - <<EOF
FROM ${BASE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade \
 && apt-get -y install \
      build-essential \
      cdbs \
      cmake \
      curl \
      devscripts \
      gfortran \
      git \
      liblapack-dev \
      mpi-default-dev \
      quilt \
      sudo \
      vim \
      wget \
 && curl -L https://sourceforge.net/projects/materiappslive/files/Debian/sources/setup.sh/download | /bin/sh \
 && apt-get update \
 && echo "unalias ls" >> /etc/skel/.bashrc

ARG USERNAME=$(id -un)
ARG GROUPNAME=$(id -gn)
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
    fi
  done
done
docker images
docker system df

#!/bin/sh

PACKAGE="ceenv"

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../config/version.sh
CODENAMES=${MA4_CODENAME}
VERSION=${MA4_DOCKER_VERSION}
LOG=build-upload-${PACKAGE}-image.log

docker login 2>&1 | tee -a ${LOG}
docker buildx create --use --name multi-arch 2>&1 | tee -a ${LOG}
docker buildx inspect --builder multi-arch --bootstrap 2>&1 | tee -a ${LOG}

for c in ${CODENAMES}; do
  for v in ${DEBIAN_VERSIONS}; do
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="malive/${PACKAGE}:${VERSION}"
      echo "building and uploading images malive/${PACKAGE}:${VERSION} and malive/${PACKAGE}:latest from ${BASE}..." 2>&1 | tee -a ${LOG}
      docker buildx build --platform linux/amd64,linux/arm64 --push -t malive/${PACKAGE}:${VERSION} -t malive/${PACKAGE}:latest - <<EOF 2>&1 | tee -a ${LOG}
FROM ${BASE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends \
      build-essential sudo lsb-release \
      less vim emacs \
      evince gnuplot-x11 \
      curl lftp wget \
      gfortran cmake git liblapack-dev libopenblas-dev mpi-default-dev numactl \
      man manpages-dev enscript time tree zip unzip bc xsel parallel \
      python3-pip python3-venv jupyter-notebook python3-numpy python3-scipy python3-matplotlib python3-tk python3-sympy python3-dev ipython3 \
 \
 && curl -L https://sourceforge.net/projects/materiappslive/files/Debian/sources/setup.sh/download | /bin/sh \
 && apt-get update -qq \
 \
 && echo "export PATH=\$HOME/bin:\$PATH" >> /etc/skel/.bashrc \
 && echo "export OMP_NUM_THREADS=1" >> /etc/skel/.bashrc \
 && echo "export OMPI_MCA_btl_vader_single_copy_mechanism=none" >> /etc/skel/.bashrc \
 && echo "export LIBGL_ALWAYS_INDIRECT=1" >> /etc/skel/.bashrc \
 && echo "unalias ls" >> /etc/skel/.bashrc \
 \
 && echo "syntax off" > /etc/skel/.vimrc \
 && mkdir -p /etc/skel/.emacs.d \
 && echo "(setq inhibit-startup-screen t)" > /etc/skel/.emacs.d/init.el \
 && echo "(setq default-frame-alist '((height . 24)))" >> /etc/skel/.emacs.d/init.el \
 && echo ${VERSION} > /etc/${PACKAGE}_version
EOF
    fi
  done
done
docker images 2>&1 | tee -a ${LOG}
docker system df 2>&1 | tee -a ${LOG}

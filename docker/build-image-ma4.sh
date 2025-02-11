#!/bin/sh

CONTAINER="malive-dev"

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../config/version.sh
. $SCRIPT_DIR/../config/package.sh

CODENAMES=${MA4_CODENAME}
VERSION=${MA4_DOCKER_VERSION}
LOG=build-image-ma4.log

for c in ${CODENAMES}; do
  echo ${c}
  for v in ${DEBIAN_VERSIONS}; do
    echo ${v}
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="${CONTAINER}:${VERSION}"
      echo "building images ${CONTAINER}:${VERSION} from ${BASE}..." 2>&1 | tee -a ${LOG}
      docker build -t ${IMAGE}  - <<EOF 2>&1 | tee -a ${LOG}
FROM ${BASE}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends ${PACKAGES_DEVELOPMENT} ${PACKAGES_PYTHON} \
 \
 && curl -L https://exa.phys.s.u-tokyo.ac.jp/archive/MateriApps/apt/setup.sh | /bin/sh \
 && apt-get update -qq \
 && apt-get -y install --no-install-recommends ${PACKAGES_APPLICATION_MA4} \
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
 && echo ${VERSION} > /etc/${PROJECT}_version
EOF
    fi
  done
done
docker images 2>&1 | tee -a ${LOG}
docker system df 2>&1 | tee -a ${LOG}

#!/bin/sh

SCRIPT_DIR=$(cd "$(dirname $0)"; pwd)
echo "SCRIPT_DIR=$SCRIPT_DIR"

. $SCRIPT_DIR/../config/version.sh
CODENAMES=${MA4_CODENAME}
VERSION=${MA4_DOCKER_VERSION}

docker buildx create --use --name multi-arch
docker buildx inspect --builder multi-arch --bootstrap

for c in ${CODENAMES}; do
  for v in ${DEBIAN_VERSIONS}; do
    if [ ${c} = $(echo ${v} | cut -d/ -f1) ]; then
      BASE=$(echo ${v} | cut -d/ -f2)
      IMAGE="malive/malive:${VERSION}"
      echo "building and uploading images malive/malive:${VERSION} and malive/malive:latest from ${BASE}..."
      docker buildx build --platform linux/amd64,linux/arm64 --push -t malive/malive:${VERSION} -t malive/malive:latest - <<EOF
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
      enscript time tree zip bc xsel parallel \
      python3-pip python3-venv jupyter-notebook python3-numpy python3-scipy python3-matplotlib python3-tk python3-sympy python3-dev ipython3 \
 \
 && curl -L https://sourceforge.net/projects/materiappslive/files/Debian/sources/setup.sh/download | /bin/sh \
 && apt-get update -qq \
 && apt-get -y install --no-install-recommends h5utils \
 && apt-get -y install --no-install-recommends materiappslive \
	bsa \
	c-tools \
	fermisurfer \
	libalpscore-dev \
        physbo \
	tapioca \
	\
        abinit \
	akaikkr \
        alamode \
        casino-setup \
	cif2cell \
        conquest \
	quantum-espresso quantum-espresso-data \
	openmx openmx-data openmx-example \
	respack \
	salmon-tddft \
	xtapp xtapp-ps xtapp-util \
	\
	gamess-setup \
	smash \
	\
	gromacs gromacs-data gromacs-openmpi \
	lammps lammps-data lammps-examples \
        octa octa-data \
	\
	alps-applications alps-tutorials \
	ddmrg \
	dsqss \
	hphi \
	mvmc \
        tenes \
	triqs triqs-cthyb triqs-dfttools triqs-hubbardi dcore \
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
 && echo ${VERSION} > /etc/malive_version
EOF
    fi
  done
done
docker images
docker system df

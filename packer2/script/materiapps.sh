#!/bin/bash -eux

echo "==> Replace MateriApps LIVE! gpg key"
apt-get -y install materiapps-keyring
rm -f /etc/apt/trusted.gpg

echo "==> Install Editors"
apt-get -y install emacs vim

echo "==> Install Graphics Tools"
apt-get -y install dx evince gnuplot-x11 ovito paraview pymol rasmol vesta vmd-setup xcrysden
# apt-get -y install gifsicle graphviz imagemagick python-pygraphviz

echo "==> Install Network Tools"
apt-get -y install curl lftp wget

echo "==> Install Development Tools"
apt-get -y install cmake git h5utils liblapack-dev libopenblas-dev mpi-default-dev numactl

echo "==> Install Other Tools"
apt-get -y install enscript time tree zip bc

echo "==> Install MateriApps Applications/Tools"
apt-get -y install materiappslive \
	bsa \
	c-tools \
	fermisurfer \
	libalpscore-dev \
	tapioca \
	\
        abinit \
	akaikkr \
        alamode \
	quantum-espresso quantum-espresso-data \
	openmx openmx-data openmx-example \
	respack \
	salmon \
	xtapp xtapp-ps xtapp-util \
	\
	gamess-setup \
	smash \
	\
	ermod \
	gromacs gromacs-data gromacs-openmpi \
	lammps lammps-data lammps-doc liblammps \
	\
	alps-applications alps-tutorials \
	ddmrg \
	dsqss \
	feram \
	hphi \
	mvmc \
	triqs triqs-cthyb triqs-dfttools triqs-hubbardi dcore

echo "==> Copy desktop file(s)"
if [ -d /etc/skel/Desktop ]; then
  cp -frp /etc/skel/Desktop $HOME
fi
if [ -d /etc/skel/.config ]; then
  cp -frp /etc/skel/.config $HOME
fi

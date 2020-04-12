#!/bin/bash -eux

echo "==> Install Graphics Tools"
apt-get -y install --no-install-recommends dx grace ovito paraview pymol rasmol vesta vmd-setup xcrysden

echo "==> Install Development Tools"
apt-get -y install --no-install-recommends h5utils

echo "==> Install MateriApps Applications/Tools"
apt-get -y install --no-install-recommends materiappslive \
	bsa \
	c-tools \
	fermisurfer \
	libalpscore-dev \
	tapioca \
	\
        abinit \
	akaikkr \
        alamode \
        casino-setup \
        conquest \
	quantum-espresso quantum-espresso-data \
	openmx openmx-data openmx-example \
	respack \
	salmon \
	xtapp xtapp-ps xtapp-util \
	\
	gamess-setup \
	smash \
	\
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

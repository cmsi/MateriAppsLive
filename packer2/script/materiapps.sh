#!/bin/bash -eux

echo "==> Install Editors"
apt-get -y install emacs vim

echo "==> Install Graphics Tools"
apt-get -y install dx evince gifsicle gnuplot-x11 graphviz imagemagick paraview pymol python-pygraphviz rasmol xcrysden

echo "==> Install Network Tools"
apt-get -y install curl lftp wget

echo "==> Install Other Tools"
apt-get -y install enscript numactl time tree

echo "==> Install MateriApps Applications/Tools"
apt-get -y install materiappslive
apt-get -y install bsa c-tools ermod quantum-espresso quantum-espresso-data feram fermisurfer hphi lammps mvmc respack smash xtapp xtapp-ps xtapp-util
apt-get -y install akaikkr alps-applications alps-tutorials libalps-dev
apt-get -y install gromacs gromacs-data gromacs-openmpi openmx openmx-data

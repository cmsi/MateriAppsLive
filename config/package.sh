ARCH=$(arch)

PACKAGES_DEVELOPMENT="sudo lsb-release \
  curl lftp wget \
  build-essential gfortran cmake git \
  liblapack-dev libopenblas-dev mpi-default-dev numactl \
  emacs vim mousepad less \
  eog evince gnuplot-x11 \
  enscript time tree zip unzip bc xsel parallel"

PACKAGES_PYTHON="python3-pip python3-venv jupyter-notebook python3-numpy python3-scipy python3-matplotlib python3-tk python3-sympy python3-dev ipython3"

PACKAGES_APPLICATION_MA4="dx grace \
  h5utils \
  bsa c-tools fermisurfer libalpscore-dev physbo tapioca \
  abinit akaikkr alamode casino-setup cif2cell conquest quantum-espresso quantum-espresso-data openmx openmx-data openmx-example respack salmon-tddft xtapp xtapp-ps xtapp-util \
  gamess-setup smash \
  gromacs gromacs-data lammps lammps-data lammps-examples octa octa-data \
  alps-applications alps-tutorials ddmrg dsqss hphi mvmc tenes triqs triqs-cthyb triqs-dfttools triqs-hubbardi dcore"

PACKAGES_APPLICATION_MA5="dx grace \
  h5utils \
  bsa c-tools fermisurfer libalpscore-dev physbo tapioca \
  abinit akaikkr alamode casino-setup cif2cell conquest quantum-espresso quantum-espresso-data openmx openmx-data openmx-example respack salmon-tddft xtapp xtapp-ps xtapp-util \
  gamess-setup smash \
  gromacs gromacs-data lammps lammps-data lammps-examples octa octa-data \
  alps-applications alps-tutorials ddmrg dsqss hphi mvmc tenes triqs triqs-cthyb triqs-dfttools triqs-hubbardi dcore"

PACKAGES_APPLICATION_GUI_MA4="ovito paraview pymol rasmol xcrysden"
if [ "$ARCH" = "x86_64" ]; then
  PACKAGES_APPLICATION_GUI_MA4="$PACKAGES_APPLICATION_GUI_MA4 vesta vmd-setup"
fi

PACKAGES_APPLICATION_GUI_MA5="ovito paraview pymol rasmol xcrysden"
if [ "$ARCH" = "x86_64" ]; then
  PACKAGES_APPLICATION_GUI_MA5="$PACKAGES_APPLICATION_GUI_MA5 vesta"
fi

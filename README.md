MateriApps LIVE! Release Files
==============================

Which archive should be used?

  - MateriAppsLive-*-i386.ova: Open Virtualization Format for VirtualBox (32bit)
  - MateriAppsLive-*-i386.hybrid.iso: Hybrid ISO Image for USB Boot (32bit)
  - MateriAppsLive-*-amd64.ova: Open Virtualization Format for VirtualBox (64bit)
  - MateriAppsLive-*-amd64.hybrid.iso: Hybrid ISO Image for USB Boot (64bit)
  - MateriAppsLive-ltx-*-i386.ova: MateriApps LIVE! + LaTeX in Open Virtualization Format for VirtualBox (32bit)
  - MateriAppsLive-ltx-*-amd64.ova: MateriApps LIVE! + LaTeX in Open Virtualization Format for VirtualBox (64bit)

MateriApps LIVE! Release x.xx (201x/xx/xx)
==========================================

  - Newly included MateriApps packages
  - Updated MateriApps packages
     * hphi (2.0.4-1)
     * xtapp (170619-1)

MateriApps LIVE! Release 1.12 (2017/07/17)
==========================================

  - Newly included MateriApps packages
     * mvmc (1.0.1-2): 
  - Updated MateriApps packages
     * akaikkr (20170222-1)
     * alps (20170127~r7841-1)
     * bsa (20151218-2)
     * feram (0.26.04-1)
     * gamess-setup (1.4)
     * hphi (2.0.2-1)
     * materiapps-keyring (20170413-1)
     * smash (2.1.0-1)
  - MateriApps Debian Package Repository has been moved from sourcesorge to
    exa.phys.s.u-tokyo.ac.jp

MateriApps LIVE! Release 1.11 (2016/09/05)
==========================================

  - Newly included MateriApps packages
     * bsa (20151218-1): Kernel Method for Finite-Size Scaling Analysis of Critical Phenomena
     * hphi (1.1.1-1): Numerical solver package for quantum lattice models
  - Newly included Python packages
     * python-pip
     * python-virtualenv
  - Updated MateriApps packages
     * alps (20160816-r7711-1)
     * c-tools (0.6.2-1)
     * ermod (0.3.4-1)
     * smash (2.0.0-1)
     * tapioca (1.7.3-1)
     * xtapp (160715-1)
     * xtapp-util (160715-1)
  - ATLAS is replaced by OpenBLAS
  - Development environment of MateriApps LIVE! has been migrated into Vagrant.
  - 64-bit architecture name has been renamed from x86_64 to amd64 according to the Debian convention.

MateriApps LIVE! Release 1.10 (2016/02/18)
==========================================

  - Newly included application packages
     * lammps, lammps-doc
  - Newly included MateriApps packages
     * paraview-wrapper (1.0-1)
     * xcrysden-wrapper (1.0-1)
  - Updated MateriApps packages
     * c-tools (0.5.2-2)
     * tapioca (1.6.11-1)
     * xtapp (150401-2)
     * xtapp-util (150401-4)

MateriApps LIVE! Release 1.9 (2015/11/27)
=========================================

  - Newly included MateriApps packages
     * dsqss (1.1.17+pv1.1.2-2)
  - Updated MateriApps packages
     * c-tools (0.5.2-1)
     * ermod (0.3.3-1)
     * smash (1.1.0-1)
     * tapioca (1.6.10-1)
     * vmd-setup (1.3)
  - Wrapper for paraview now set LIBGL_ALWAYS_SOFTWARE=1 to prevent warning messages
  - Changed MateriApps Debian repository to sourceforge

MateriApps LIVE! Release 1.8 (2015/08/31)
=========================================

  - Newly included visualization tools
     * vmd-setup: VMD Setup Tool (for 1.9.2)
  - Updated MateriApps packages
     * alps (20150825-r7620)
     * feram (0.24.02)
     * gamess-setup (for December 5, 2014 R1)
  - Updated Visualization tools
     * paraview (3.14.1-6+1)
  - Allowed to open popup window in Iceweasel by default
  - Added MateriApps LIVE! login background in OVA
  - Enable accelerate3d and usb support in VirtualBox
  - Added link menu items to PDB

MateriApps LIVE! Release 1.7 (2015/07/27)
=========================================

  - Newly included MateriApps tools
     * c-tools (0.3.1)
  - Newly included visualization tools
     * avogadro (1.0.3)
     * rasmol (2.7.5.2)
     * vesta (3.3.0)
  - Updated MateriApps packages
     * ermod (0.3.1): New upstream release
     * openmx (3.7.8): Added utilities for postprocessing: bandgnu13 and DosMain
     * tapioca (1.6.2): New upstream release
     * xtapp-util (150401): Added missing utilities: disp2fset.py, disp2xti.py, rho2xsf, stm2cci, exrho2dx, wfneig, etc
  - Added link menu items to databases of materials science
     
MateriApps LIVE! Release 1.6 (2015/04/02)
=========================================

  - Following binary images are provided
     * ISO boot image (MateriAppsLive-1.6-*.hybrid.iso) for 64bit (amd64) and 32bit (i386) architectures
     * VirtualBox Disk Images (OVA) (MateriAppsLive-1.6-*.ova) for 64bit (amd64) and 32bit (i386) architectures
     * VirtualBox Disk Images (OVA) with Japanese texlive packages (MateriAppsLive-ltx-1.6-*.ova) for 64bit (amd64) and 32bit (i386) architectures
     * For more information, see ["Using MateriApps LIVE! on VirtualBox"](https://github.com/cmsi/MateriAppsLive/wiki/Using-MateriApps-LIVE!-on-VirtualBox)
  - Updated MateriApps packages
     * alps: New upstream snapshot (20150402-r7566)
     * xtapp, xtapp-util: New upstream release (150401)
     * xtapp-ps, xtapp-ps-extra: CAPZ and norm-conserving + PBE pseudo potentials have been moved to xtapp-ps-extra package and made optional.
  - Removed LibreOffice, Java, XSane to reduce the image size

MateriApps LIVE! Release 1.5 (2015/03/12, 2015/03/28)
=====================================================

  - 64bit (amd64) as well as 32bit (i386) architecture
  - VirtualBox Disk Images (OVA) are provided in addition to ISO boot images
  - Updated MateriApps applications
     * feram (0.22.06-1)
     * Tapioca (1.5.0-1)
  - Newly included visualization tools
     * XCrySDen
  - Newly included debian packages
     * numactl
  - Replaced GPG public key by the one from materiapps-keyring package
  - Included English version of ["Getting Started"](https://github.com/cmsi/MateriAppsLive/wiki/GettingStarted)

MateriApps LIVE! Release 1.4 (2014/09/18)
===========================================

  - Newly included MateriApps applications
     * SMASH (1.0.1-1)
  - Updated MateriApps applications
     * AkaiKKR (20140905-1)
         - Supported OpenMP parallelization
     * ERmod (ermod 0.2.4-3, ermod-example-gromacs 20120406-1)
         - Fixed permission of ERmod plugins
         - Added Gromacs sample trajectory for ERmod example
         - Fixed compile option for compatibility
     * OpenMX (openmx 3.7.8-1, openmx-data 3.7.8-1, openmx-example 3.7.8-1)
         - New upstream 3.7.8
     * xTAPP (xtapp 140916-2, xtapp-util 140916-1, xtapp-ps 140401-1)
         - New upstream 140916
         - Added CAPZ and PBE-nc pseudo potential
  - Newly included visualization tools
     * Gifsicle
     * ImageMagick
  - Fixed paraview startup problem in Japanese environment
  - Updated ["Getting Started"](https://github.com/cmsi/MateriAppsLive/wiki/GettingStarted) document

MateriApps LIVE! Release 1.3 (2014/07/19)
===========================================

  - Added off-line tutorial ["Getting Started"](https://github.com/cmsi/MateriAppsLive/wiki/GettingStarted) on Desktop
  - Removed "Install" menu from default boot menu
  - Added boot option with LANG=en KBD=jp
  - Updated MateriApps applications
     * AkaiKKR (renamed from MachKKR) (20130914-1)
     * ALPS (20140623-r7482-1)
     * feram (0.22.04-1)
     * xTAPP (patch for moldyn) (140129-5)
  - Added source repository for MateriApps LIVE!

MateriApps LIVE! Release 1.2 (2014/03/14)
===========================================

  - [New download site](http://exa.phys.s.u-tokyo.ac.jp/archive/MateriApps/apt) for MateriApps Debian Packages
  - Newly included MateriApps applications
     * MachKKR (previously known as AkaiKKR or Machikaneyama2002) (20130914)
  - Updated MateriApps applications
     * ALPS (20140309-r7370)
     * feram (0.22.1)
     * xTAPP (140129)
  - Updated MateriApps visualization tools
     * TAPIOCA (1.4.2)
  - Removed packages
     * Machikaneyama Setup Tools (replaced by MachKKR package)

MateriApps LIVE! Release 1.1 (2013/09/25)
===========================================

  - New MateriApps LIVE! logo
  - Newly included MateriApps Applications
     * xTAPP (130919)
     * GAMESS Setup Tool (for May 1, 2013 R1)
  - Newly included visualization tools
     * TAPIOCA (1.3.3)
     * OpenDX (4.4.4)
  - Updated MateriApps Applications
     * feram (0.21.04)
     * Machikaneyama Setup Tool (for cpa2002v009c Sep. 14, 2013)

MateriApps LIVE! Release 1.0 (2013/07/26)
===========================================

  - First released version of MateriApps LIVE!
  - Based on Debian GNU/Linux (wheezy) amd64
  - Newly included MateriApps Applications
     * ABINIT (5.3.4)
     * ALPS (20130626-r6962)
     * CP2K (2.2.426)
     * feram (0.21.02)
     * ERmod (0.2.4)
     * Gromacs (4.5.5)
     * Machikaneyama Setup Tool (for cpa2002v009c July 23, 2013)
     * OpenMX (3.5)
     * Quantum Espresso (5.0)
  - Newly included visualization tools
     * paraview (3.14.1)
     * pymol (1.5.0.1)

References
==========

 - [MateriApps LIVE!](http://cmsi.github.io/MateriAppsLive)
 - [MateriApps LIVE! Wiki](https://github.com/cmsi/MateriAppsLive/wiki)
 - [MateriApps LIVE! Forum](http://ma.cms-initiative.jp/ja/community/materiapps-messageboard/materiapps-live)

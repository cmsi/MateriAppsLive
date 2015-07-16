MateriApps LIVE! Release 1.7 (2015/xx/xx)
=========================================

  - Newly included MateriApps tools
     * c-tools (0.3.1-1)
     * rasmol (2.7.5.2.1)
  - Updated MateriApps packages
     * ermod (0.3.1-1): New upstream release
     * tapioca (1.6.2-1): New upstream release
     * xtapp-util (150401-3): Added missing utilities: disp2fset.py, disp2xti.py, rho2xsf, stm2cci, exrho2dx, wfneig, etc
     
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
 - [How to make LIVE! USB?](http://github.com/cmsi/MateriAppsLive/wiki/HowToMakeLiveUSB)
 - [MateriApps LIVE! Forum](http://ma.cms-initiative.jp/ja/community/materiapps-messageboard/materiapps-live)

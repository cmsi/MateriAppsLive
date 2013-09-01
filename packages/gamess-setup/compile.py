#! /usr/bin/python

# Compile script for GAMESS written by Synge Todo

import sys
import subprocess
import os, os.path
import re

import config

def CompileAndInstall(file, prefix):
    sharedir = prefix + '/share'
    gamessdir = sharedir + '/gamess'

    # Extract files from the tarball
    if (not os.path.isdir(sharedir)):
        os.mkdir(sharedir)
    print "Extracting", file + "..."
    cmd = ['tar', 'zxvf', file, '-C', sharedir]
    p = subprocess.check_call(cmd)

    # Generate config file
    print "Generating " + gamessdir + '/install.info'
    with open(gamessdir + '/install.info', 'w') as f:
        f.write('setenv GMS_PATH ' + gamessdir + '\n') 
        f.write('setenv GMS_BUILD_DIR ' + gamessdir + '\n') 
        f.write('setenv GMS_TARGET linux64\n') 
        f.write('setenv GMS_FORTRAN gfortran\n')
        f.write('setenv GMS_GFORTRAN_VERNO 4.7\n')
        f.write('setenv GMS_MATHLIB atlas\n')
        f.write('setenv GMS_MATHLIB_PATH /usr/lib\n')
        f.write('setenv GMS_DDI_COMM sockets\n')
        f.write('setenv GMS_LIBCCHEM false\n')
    print "Generating " + gamessdir + '/Makefile'
    with open(gamessdir + '/Makefile', 'w') as f:
        f.write('GMS_PATH = ' + gamessdir + '\n')
        f.write('GMS_VERSION = 00\n')
        f.write('GMS_BUILD_PATH = ' + gamessdir + '\n')
        f.write('include $(GMS_PATH)/Makefile.in\n')

    # Generate tools/actvte.x
    print "Generating tools/actvte.x"
    with open(gamessdir + '/tools/actvte.code', 'r') as fin:
        with open(gamessdir + '/tools/actvte.f', 'w') as fout:
            for line in fin.readlines():
                fout.write(re.sub('^\*UNX', '    ', line))
    cmd = ['gfortran', '-O2', '-o', gamessdir + '/tools/actvte.x', gamessdir + '/tools/actvte.f']
    p = subprocess.check_call(cmd) 

    # Compile
    print "Compiling GAMESS"
    cmd = ['make', '-C', gamessdir]
    p = subprocess.check_call(cmd)

    # patch to rungms and install into prefix/bin
    print "Applying patch to rungms..."
    patch = os.path.join(os.path.abspath(os.path.dirname(__file__)), "rungms.patch")
    cmd = ['patch', '-i', patch, '-p', '0', '-d', gamessdir]
    p = subprocess.check_call(cmd)
    print "Making symbolic to " + prefix + "/bin/rungms"
    if (os.path.exists(prefix + "/bin/rungms")):
        os.remove(prefix + "/bin/rungms")
    cmd = ['ln', '-s', gamessdir + "/rungms", prefix + "/bin/rungms"]
    p = subprocess.check_call(cmd)

    return 0
        
if __name__ == '__main__':
    if (len(sys.argv) != 3):
        print "Usage:", sys.argv[0], "source_tarball prefix"
        sys.exit(127)
    source = sys.argv[1]
    prefix = sys.argv[2]
    ret = CompileAndInstall(source, prefix)
    sys.exit(ret)

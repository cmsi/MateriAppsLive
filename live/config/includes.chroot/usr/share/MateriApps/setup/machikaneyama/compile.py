#! /usr/bin/python

# Compile script for Machikaneyama 2002 written by Synge Todo

import sys
import subprocess
import os, os.path

import config

def CompileAndInstall(version, file, prefix, compiler, option):
    # Extract files from the tarball
    print "Extracting", file + "..."
    cmd = ['tar', 'zxvf', file]
    p = subprocess.check_call(cmd)

    # Patch
    print "Applying patch..."
    patch = os.path.join(os.path.abspath(os.path.dirname(__file__)), version + ".patch")
    cmd = ['patch', '-i', patch, '-p', '1', '-d', version]
    p = subprocess.check_call(cmd)
    
    # Make
    cmd = ['make', '-C', version]
    if (compiler):
        cmd.append("fort=" + compiler)
    if (option):
        cmd.append("flag=" + option)
    print "Compiling with", cmd, "..."
    p = subprocess.check_call(cmd)

    # Install
    cmd = ['make', '-C', version]
    if (prefix):
        cmd.append("prefix=" + prefix)
    cmd.append("install")
    print "Installing with", cmd, "..."
    p = subprocess.check_call(cmd)
    return 0
        
if __name__ == '__main__':
    if (len(sys.argv) < 2):
        print "Usage:", sys.argv[0], "prefix [compiler] [option]"
        sys.exit(127)
    prefix = sys.argv[1]
    compiler = ""
    option = ""
    if (len(sys.argv) >= 3):
        compiler = sys.argv[2]
    if (len(sys.argv) >= 4):
        option = sys.argv[3]
    ret = CompileAndInstall(config.version, config.tarfile, prefix, compiler, option)
    sys.exit(ret)

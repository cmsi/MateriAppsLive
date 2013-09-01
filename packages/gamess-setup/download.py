#! /usr/bin/python

# Download script for GAMESS written by Synge Todo

import os
import sys
import subprocess

import config

def Download(username, password, targetdir):
    if (not os.path.isdir(targetdir)):
        os.mkdir(targetdir)
    print "Downloading " + config.url + "..."
    cmd = ['wget', '--http-user=' + username, '--http-password=' + password, '--output-document=' + targetdir + '/' + config.file, config.url]
    p = subprocess.check_call(cmd)
    print "Done."
    return 0

if __name__ == '__main__':
    if (len(sys.argv) != 4):
        print "Usage:", sys.argv[0], "username", "password", "target_directory"
        sys.exit(127)
    username = sys.argv[1]
    password = sys.argv[2]
    targetdir = sys.argv[3]
    ret = Download(username, password, targetdir)
    sys.exit(ret)

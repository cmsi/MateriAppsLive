#! /usr/bin/python

base_url = "http://www.msg.chem.iastate.edu"
dir = "GAMESS/download/source"
file = "gamess-current.tar.gz"
url = base_url + "/" + dir + "/" + file

if __name__ == '__main__':
    print "base_url =", base_url
    print "dir =", dir
    print "file =", file
    print "url =", url

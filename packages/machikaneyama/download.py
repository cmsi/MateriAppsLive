#! /usr/bin/python

# Download script for Machikaneyama 2002 written by Synge Todo
#
# reference:
#   Emulating a Browser in Python with mechanize
#   http://stockrt.github.io/p/emulating-a-browser-in-python-with-mechanize/

import sys
import mechanize

url = "http://kkr.phys.sci.osaka-u.ac.jp/download.cgi"
file = "cpa2002v009c.tar.gz"

if (len(sys.argv) != 3):
    print "Usage:", sys.argv[0], "email", "password"
    sys.exit(127)
email = sys.argv[1]
password = sys.argv[2]

# Browser
br = mechanize.Browser()

# Browser options
br.set_handle_equiv(True)
br.set_handle_redirect(True)
br.set_handle_referer(True)
br.set_handle_robots(False)

# Follows refresh 0 but not hangs on refresh > 0
br.set_handle_refresh(mechanize._http.HTTPRefreshProcessor(), max_time=1)

# Open Machikaneyama download page
print "Connecting to", url, "..."
res = br.open(url)

# Fill form with email and password
print "Submitting email and password ..."
br.select_form(nr = 0)
br["MAIL"] = email
br["PW"] = password
br.submit()
try:
    req = br.click_link(text = file)
except mechanize._mechanize.LinkNotFoundError:
    print "Invalid email and/or password"
    sys.exit(127)

# Download tarball
print "Downloading", file, "..."
br.open(req)
body = br.response().read()
f = open(file, 'w')
f.write(body)
f.close()

print "Done"
sys.exit(0)

#!/usr/bin/python

import json
import glob
import re

files = glob.glob('./debian-repos.json')

for afile in files:
    with open(afile) as f:
        jsons = json.loads(f.read().strip())
        for j in jsons:
            if (re.match('ma-', j['name'])):
                pkg = re.sub('ma-', '', j['name'])
                print('{} {} {}'.format(pkg, j['html_url'], j['description']))

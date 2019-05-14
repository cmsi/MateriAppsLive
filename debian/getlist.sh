#!/bin/sh

# ref: https://qiita.com/emergent/items/a557246a0c0bf9d50a11

set -x

curl "https://api.github.com/orgs/cmsi/repos?per_page=100&page=1" > debian-repos.json

python getlist.py | sort > debian-repos.txt

echo "List of Debian package repositories have been stored into debian-repos.txt."

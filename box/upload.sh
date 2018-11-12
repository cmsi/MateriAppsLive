#!/bin/sh

rsync -avP -e ssh box/virtualbox/debian*.box box/virtualbox/debian*.json frs.sourceforge.net:/home/frs/project/materiappslive/Debian/box/

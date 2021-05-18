#!/bin/sh

if [ $(lsb_release -s -i) = 'Debian' -o $(lsb_release -s -i) = 'Ubuntu' ]; then :; else
  exit 127
fi

SCRIPTDIR=$(cd $(dirname $0) && pwd)
BASEDIR=$(cd $SCRIPTDIR/.. && pwd)
REPOSITORY="https://github.com/cmsi/MateriAppsLive.wiki.git"
WIKIDIR="$BASEDIR/MateriAppsLive.wiki"

# sudo apt-get -y install ruby-dev rubygems
# sudo gem install github-markdown

if test -f "/var/lib/gems/2.1.0/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/2.1.0/gems/github-markdown-0.6.9/bin/gfm"
elif test -f "/var/lib/gems/1.9.1/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/1.9.1/gems/github-markdown-0.6.9/bin/gfm"
elif test -f "/var/lib/gems/2.3.0/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/2.3.0/gems/github-markdown-0.6.9/bin/gfm"
elif test -f "/var/lib/gems/2.5.0/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/2.5.0/gems/github-markdown-0.6.9/bin/gfm"
else
  echo "Error: gfm not found"
  exit 127
fi

CSS="https://gist.githubusercontent.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css"

if test -d $WIKIDIR; then
  (cd $WIKIDIR && git pull)
else
  (cd $BASEDIR && git clone $REPOSITORY)
fi

cat << EOF > $SCRIPTDIR/README.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE!</title>
  <style type="text/css">
<!--
EOF

wget -O - "$CSS" >> $SCRIPTDIR/README.html

cat << EOF >> $SCRIPTDIR/README.html
-->
  </style>
</head>
<body>
EOF

$GFM --readme $WIKIDIR/MateriAppsLive-ova.md >> $SCRIPTDIR/README.html

cat << EOF >> $SCRIPTDIR/README.html
</body>
</html>
EOF

## en

cat << EOF > $SCRIPTDIR/README-en.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE!</title>
  <style type="text/css">
<!--
EOF

wget -O - "$CSS" >> $SCRIPTDIR/README-en.html

cat << EOF >> $SCRIPTDIR/README-en.html
-->
  </style>
</head>
<body>
EOF

$GFM --readme $WIKIDIR/MateriAppsLive-ova-en.md >> $SCRIPTDIR/README-en.html

cat << EOF >> $SCRIPTDIR/README-en.html
</body>
</html>
EOF

FILES="$SCRIPTDIR/README.html $SCRIPTDIR/README-en.html"
for file in $FILES; do
  sed -i 's%<a href="MateriAppsLive-ova">%<a href="README.html">%' $file
  sed -i 's%<a href="MateriAppsLive-ova-en">%<a href="README-en.html">%' $file
done

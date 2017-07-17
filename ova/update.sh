#!/bin/sh

SCRIPT_DIR=$(dirname $0)
REPOSITORY="https://github.com/cmsi/MateriAppsLive.wiki.git"
SRCDIR="MateriAppsLive.wiki"

if test -f "/var/lib/gems/2.1.0/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/2.1.0/gems/github-markdown-0.6.9/bin/gfm"
elif test -f "/var/lib/gems/1.9.1/gems/github-markdown-0.6.9/bin/gfm"; then
  GFM="/var/lib/gems/1.9.1/gems/github-markdown-0.6.9/bin/gfm"
else
  echo "Error: gfm not found"
  exit 127
fi

CSS="https://gist.githubusercontent.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css"

cd $SCRIPT_DIR
rm -rf $SRCDIR
git clone $REPOSITORY $SRCDIR

wget -O github.css "$CSS"

cat << EOF > README.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! VirtualBox版</title>
  <style type="text/css">
<!--
EOF

wget -O - "$CSS" >> README.html

cat << EOF >> README.html
-->
  </style>
</head>
<body>
EOF

$GFM --readme $SRCDIR/MateriAppsLive-ova.md >> README.html

cat << EOF >> README.html
</body>
</html>
EOF

## en

cat << EOF > README-en.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! VirtualBox Edition</title>
  <style type="text/css">
<!--
EOF

wget -O - "$CSS" >> README-en.html

cat << EOF >> README-en.html
-->
  </style>
</head>
<body>
EOF

$GFM --readme $SRCDIR/MateriAppsLive-ova-en.md >> README-en.html

cat << EOF >> README-en.html
</body>
</html>
EOF

FILES="README.html README-en.html"
for file in $FILES; do
  sed -i 's%<a href="MateriAppsLive-ova">%<a href="README.html">%' $file
  sed -i 's%<a href="MateriAppsLive-ova-en">%<a href="README-en.html">%' $file
done

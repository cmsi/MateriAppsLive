#!/bin/sh

REPOSITORY="https://github.com/cmsi/MateriAppsLive.wiki.git"
SRCDIR="MateriAppsLive.wiki"

GFM="/var/lib/gems/1.9.1/gems/github-markdown-0.6.9/bin/gfm"
if [ -x "$GFM" ]; then :; else
  echo "Error: not found $GFM"
  exit 127
fi

CSS="https://gist.githubusercontent.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css"

if [ -d "$SRCDIR" ]; then
  (cd "$SRCDIR" && git fetch && git merge origin/master)
else
  git clone $REPOSITORY $SRCDIR
fi

## ja

cat << EOF > README.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! LTX版</title>
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

$GFM --readme $SRCDIR/MateriAppsLive-ltx.md | sed 's%<a href="https://github.com/cmsi/MateriAppsLive/wiki/MateriAppsLive-ltx-en">English</a>%<a href="README-en.html">English</a>%' >> README.html

cat << EOF >> README.html
</body>
</html>
EOF

## en

cat << EOF > README-en.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! LTX Version</title>
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

$GFM --readme $SRCDIR/MateriAppsLive-ltx-en.md | sed 's%<a href="https://github.com/cmsi/MateriAppsLive/wiki/MateriAppsLive-ltx">日本語</a>%<a href="README.html">日本語</a>%' >> README-en.html

cat << EOF >> README-en.html
</body>
</html>
EOF

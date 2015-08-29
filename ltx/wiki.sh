#!/bin/sh

REPOSITORY="https://github.com/cmsi/MateriAppsLive.wiki.git"
SRCDIR="MateriAppsLive.wiki"

GFM="/var/lib/gems/1.9.1/gems/github-markdown-0.6.5/bin/gfm"
if [ -x "$GFM" ]; then :; else
  echo "Error: not found $GFM"
  exit 127
fi

CSS="https://gist.githubusercontent.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css"

git clone $REPOSITORY $SRCDIR

wget -O github.css "$CSS"

cat << EOF > README.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! LTX版</title>
  <link rel="stylesheet" href="github.css" type="text/css" />
</head>
<body>
EOF

$GFM --readme $SRCDIR/MateriAppsLive-ltx.md >> README.html

cat << EOF >> README.html
</body>
</html>
EOF

#!/bin/sh

SRCDIR="$HOME/development/MateriAppsLive.wiki"

GFM="/var/lib/gems/1.9.1/gems/github-markdown-0.6.5/bin/gfm"

CSS="https://gist.githubusercontent.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css"

wget -O github.css "$CSS"

cat << EOF > README.html
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>MateriApps LIVE! OVA版</title>
  <link rel="stylesheet" href="github.css" type="text/css" />
</head>
<body>
EOF

$GFM --readme $SRCDIR/MateriAppsLive-ova.md >> README.html

cat << EOF >> README.html
</body>
</html>
EOF

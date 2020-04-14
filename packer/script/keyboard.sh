#!/bin/bash -eux

echo "==> Add menu items for keyboard setting"

cat << EOF > /usr/share/applications/setxkbmap-jp.desktop
[Desktop Entry]
Name=Switch to Japanese Keyboard Layout
TryExec=setxkbmap
Exec=setxkbmap -layout jp
Type=Application
Categories=System
EOF

cat << EOF > /usr/share/applications/setxkbmap-us.desktop
[Desktop Entry]
Name=Switch to English Keyboard Layout
TryExec=setxkbmap
Exec=setxkbmap -layout us
Type=Application
Categories=System
EOF

cat << EOF > /usr/share/applications/setxkbmap-swap.desktop
[Desktop Entry]
Name=Swap CapsLock and Control
TryExec=setxkbmap
Exec=setxkbmap -option ctrl:swapcaps
Type=Application
Categories=System
EOF

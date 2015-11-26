#!/bin/sh

echo "VBoxManage setextradata global GUI/SuppressMessages all"
VBoxManage setextradata global GUI/SuppressMessages all

echo "Type Enter key to finish" && read wait

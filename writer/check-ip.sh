#!/bin/sh
# script for sending client IP address

DEV=eth0
HOST=url_of_server
KEY=$(hostname)

export LANG=C

UP=$(/sbin/ifconfig "$DEV" | grep UP > /dev/null 2>&1; echo $?)
if test "$UP" = 0; then
  IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | awk '{print $2}' | sed 's/addr://g')
  echo "link is up and IP address is $IP"
  URL="$HOST/$KEY/$IP"
  COMMAND="/usr/bin/wget -q $URL"
  echo "$COMMAND"
  $COMMAND
else
  echo "link is down"
fi

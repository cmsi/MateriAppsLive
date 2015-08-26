#!/bin/sh
# script for generating IP list from access_log

IDS="list_of_client_ids"
LOG="/somewhere/access_log"
HTML="/somewhere/iplist.html"

cat << EOF > $HTML
<HTML>
<HEAD>
<TITLE>IP Address</TITLE>
</HEAD>
<BODY>
<TABLE BORDER=1>
  <TR><TH>ID</TH><TH>Last Update</TH><TH>IP Address</TH></TR>
EOF
for ID in $IDS; do
  DATE=$(grep $ID $LOG | tail -1 | awk '{print $4,$5}')
  IP=$(grep $ID $LOG | tail -1 | awk '{print $7}' | awk -F / '{print $3}')
  echo "  <TR><TD>$ID</TD><TD>$DATE</TD><TD>$IP</TD></TR>" >> $HTML
done
cat << EOF >> $HTML
</TABLE>
</BODY>
</HTML>
EOF

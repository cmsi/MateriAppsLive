#!/bin/bash -eux

echo "==> Setup Firefox preferences"

FIREFOX_PREFS=/etc/firefox-esr/profile/prefs.js

mkdir -p $(dirname ${FIREFOX_PREFS})

cat << EOF >> ${FIREFOX_PREFS}
/* MateriApps Live tune */
user_pref("browser.cache.disk.smart_size.enabled", false);
user_pref("browser.cache.disk.capacity", 5000);
user_pref("browser.startup.homepage", "http://ma.issp.u-tokyo.ac.jp/");
/* Enable Popups */
user_pref("dom.disable_open_during_load", false);
EOF

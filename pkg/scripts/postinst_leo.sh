#!/bin/sh

[[ -d /usr/X11/include/libpng14 ]] && rm -rf /usr/X11/include/libpng14
[[ -f /usr/X11/bin/libpng14-config ]] && rm /usr/X11/bin/libpng14-config

# Load the privileged_startx daemon
/bin/launchctl unload -w /System/Library/LaunchDaemons/org.x.privileged_startx.plist >& /dev/null
/bin/launchctl load -w /System/Library/LaunchDaemons/org.x.privileged_startx.plist

# Cache system fonts
/usr/X11/bin/font_cache --force --system

exit 0

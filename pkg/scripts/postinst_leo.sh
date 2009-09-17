#!/bin/sh
# Cache system fonts
/usr/X11/bin/font_cache --force --system

# Load the privileged_startx daemon
/bin/launchctl unload -w /System/Library/LaunchDaemons/org.x.privileged_startx.plist >& /dev/null
/bin/launchctl load -w /System/Library/LaunchDaemons/org.x.privileged_startx.plist

if [ -d /usr/X11/share/X11/xkb ] ; then
	rm -rf /usr/X11/share/X11/xkb
fi

exit 0

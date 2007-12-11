#!/bin/sh
/bin/launchctl load -w /System/Library/LaunchAgents/org.x.fontconfig.plist
/usr/X11/bin/fc-cache

if [[ -d /usr/X11/X11.app ]] ; then
        rm -rf /usr/X11/X11.app
fi

exit 0




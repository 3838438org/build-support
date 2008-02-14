#!/bin/sh
# Kill off old X11.app before installing because relocation will use this one
if [[ -d /usr/X11/X11.app ]] ; then
        rm -rf /usr/X11/X11.app
fi

/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.fontconfig.plist
if [ -f /System/Library/LaunchAgents/org.x.fontconfig.plist ] ; then
        rm /System/Library/LaunchAgents/org.x.fontconfig.plist
fi

exit 0




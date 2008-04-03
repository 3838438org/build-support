#!/bin/sh

# Remove the symlink from Leopard's X11
if [[ -h /usr/X11R6 ]] ; then
	rm /usr/X11R6
fi

if [[ -h /usr/include/X11 ]] ; then
	rm /usr/include/X11
fi

ln -s ../X11R6/include/X11 /usr/include/X11

if [[ -d /Applications/Utilities/X11.app ]] ; then
	rm -rf /Applications/Utilities/X11.app
fi

if [ -f /System/Library/LaunchAgents/org.x.x11.plist ] ; then
	/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.x11.plist
fi

# This is old stuffs that can be removed
if [ -f /System/Library/LaunchAgents/org.x.fontconfig.plist ] ; then
	/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.fontconfig.plist
        rm /System/Library/LaunchAgents/org.x.fontconfig.plist
fi

exit 0




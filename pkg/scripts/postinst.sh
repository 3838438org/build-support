#!/bin/sh
# Load the fontconfig launchd.plist
/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.fontconfig.plist
if [ -f /System/Library/LaunchAgents/org.x.fontconfig.plist ] ; then
	rm /System/Library/LaunchAgents/org.x.fontconfig.plist
fi
/bin/launchctl load -w /System/Library/LaunchDaemons/org.x.fontconfig.plist

exit 0




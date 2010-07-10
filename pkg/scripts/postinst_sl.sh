#!/bin/sh
# Cache system fonts
/opt/X11/bin/font_cache --force --system

# Load the privileged_startx daemon
/bin/launchctl unload -w /Library/LaunchDaemons/org.macosforge.xquartz.privileged_startx.plist
/bin/launchctl load -w /Library/LaunchDaemons/org.macosforge.xquartz.privileged_startx.plist

[[ -f /etc/paths.d/XQuartz ]] && rm /etc/paths.d/XQuartz 
[[ -f /etc/manpaths.d/XQuartz ]] && rm /etc/manpaths.d/XQuartz 

exit 0

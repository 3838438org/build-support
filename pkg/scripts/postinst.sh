#!/bin/sh
# Load the fontconfig launchd.plist
/bin/launchctl load -w /System/Library/LaunchAgents/org.x.fontconfig.plist

# Update font info
/usr/X11/bin/fc-cache
for d in {,/System}/Library/Fonts ; do
	/usr/X11/bin/mkfontdir ${d}
	/usr/X11/bin/mkfontscale ${d}
done

exit 0




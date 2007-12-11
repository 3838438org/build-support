#!/bin/sh
# Load the fontconfig launchd.plist
/bin/launchctl load -w /System/Library/LaunchAgents/org.x.fontconfig.plist

# Update font info
/usr/X11/bin/fc-cache
for d in {,/System}/Library/Fonts ; do
	/usr/X11/bin/mkfontdir ${d}
	/usr/X11/bin/mkfontscale ${d}
done

# Kill off old X11.app
if [[ -d /usr/X11/X11.app ]] ; then
        rm -rf /usr/X11/X11.app
fi

exit 0




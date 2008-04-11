#!/bin/sh
# Kill off old X11.app before installing because relocation will use this one
if [[ -d /usr/X11/X11.app ]] ; then
        rm -rf /usr/X11/X11.app
fi

# Remove these, so the new compressed man pages are used
if [[ -f /usr/share/man/man1/quartz-wm.1 ]] ; then
	rm /usr/share/man/man1/quartz-wm.1
fi
if [[ -d /usr/X11/man && ! -h /usr/X11/man ]] ; then
	rm -rf /usr/X11/man
fi

# This plist is the old name (and the future name for X11.app)
if [ -f /System/Library/LaunchAgents/org.x.X11.plist ] ; then
	/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.X11.plist
        rm /System/Library/LaunchAgents/org.x.X11.plist
fi

# This is done now by startx
if [ -f /System/Library/LaunchAgents/org.x.fontconfig.plist ] ; then
	/bin/launchctl unload -w /System/Library/LaunchAgents/org.x.fontconfig.plist
        rm /System/Library/LaunchAgents/org.x.fontconfig.plist
fi

# This is done now by privileged_startx
if [ -f /System/Library/LaunchDaemons/org.x.font_cache.plist ] ; then
	/bin/launchctl unload -w /System/Library/LaunchDaemons/org.x.font_cache.plist
	rm /System/Library/LaunchDaemons/org.x.font_cache.plist
fi

exit 0

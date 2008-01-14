#!/bin/sh
# Kill off old X11.app before installing because relocation will use this one
if [[ -d /usr/X11/X11.app ]] ; then
        rm -rf /usr/X11/X11.app
fi

exit 0




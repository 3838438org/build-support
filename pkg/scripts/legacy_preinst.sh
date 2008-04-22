#!/bin/sh

# Remove the symlink from Leopard's X11
if [[ -h /usr/X11R6 ]] ; then
	rm /usr/X11R6
fi

exit 0




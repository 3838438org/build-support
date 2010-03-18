#!/bin/sh

. ~/src/strip.sh

unset CFLAGS OBJCFLAGS CPPFLAGS LDFLAGS C_INCLUDE_PATH OBJC_INCLUDE_PATH CPLUS_INCLUDE_PATH

MERGE_DIR="/Users/jeremy/src/freedesktop/pkg/X11_Legacy"
#MERGE_DIR="/"

X11LEGACY="trains/SUTiger"
XPLUGIN="trunk"
QUARTZWM="trunk"

### End Configuration ###

die() {
	echo "${@}" >&2
	exit 1
}

ARCH_32="-arch i386 -arch ppc"
ARCH_ALL="${ARCH_32} -arch x86_64 -arch ppc64"

#~rc/bin/buildit X11_Xplugin/${XPLUGIN} -project X11_Xplugin ${ARCH_ALL} -merge ${MERGE_DIR} || die
~rc/bin/buildit X11_legacy/${X11LEGACY} -project X11 -release SUIncaZip -merge ${MERGE_DIR} || die
#~rc/bin/buildit X11_quartz_wm/${QUARTZWM} -project X11_quartz_wm ${ARCH_32} -merge ${MERGE_DIR} || die

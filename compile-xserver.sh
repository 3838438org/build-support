#!/bin/bash

#CONFIGURE="./autogen.sh"
CONFIGURE="./configure"
#CONFOPT="--disable-xquartz --disable-launchd --enable-kdrive --disable-xsdl --enable-xnest --enable-xvfb"
#CONFOPT="--disable-glx"

#MESA="$(pwd)/../Mesa-6.5.2"
#MESA="$(pwd)/../Mesa-7.0.4"
MESA="$(pwd)/mesa"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="gnumake"
MAKE_OPTS="-j2"
 
. ~/src/strip.sh

ACLOCAL="aclocal -I /usr/X11/share/aclocal"

CFLAGS="-Wall -pipe -DNO_ALLOCA"
CFLAGS="$CFLAGS -O0 -ggdb3"
#CFLAGS="$CFLAGS -O2"
CFLAGS="$CFLAGS -arch i386 -arch ppc"

LDFLAGS="$CFLAGS"

CPPFLAGS="$CPPFLAGS -F/Applications/Utilities/X11.app/Contents/Frameworks"
LDFLAGS="$LDFLAGS -F/Applications/Utilities/X11.app/Contents/Frameworks"

export ACLOCAL CPPFLAGS CFLAGS LDFLAGS


die() {
	echo "${@}" >&2
	exit 1
}

docomp() {
	${CONFIGURE} --prefix=/usr/X11 --with-mesa-source="${MESA}" ${CONFOPT} --disable-dependency-tracking --enable-maintainer-mode --enable-xcsecurity --enable-record --enable-sparkle "${@}" || die "Could not configure xserver"
	${MAKE} clean || die "Unable to make clean"
	${MAKE} ${MAKE_OPTS} || die "Could not make xserver"
}

doinst() {
	${MAKE} install DESTDIR="$(pwd)/../dist" || die "Could not install xserver"
}

dosign() {
	/opt/local/bin/gmd5sum $1 > $1.md5sum
	/opt/local/bin/gsha1sum $1 > $1.sha1sum
	/opt/local/bin/gpg -b $1
}

dodist() {
	${MAKE} dist
	cp hw/xquartz/mach-startup/X11.bin X11.bin-$1
	cp hw/xquartz/mach-startup/Xquartz Xquartz-$1
	bzip2 X11.bin-$1
	bzip2 Xquartz-$1
	dosign X11.bin-$1.bz2 
	dosign Xquartz-$1.bz2 
	dosign xorg-server-$1.tar.bz2
}

docomp `[ -f conf_flags ] && cat conf_flags`
#doinst
[[ -n $1 ]] && dodist $1

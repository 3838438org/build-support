#!/bin/bash

CONFIGURE="./autogen.sh"
#CONFIGURE="./configure"
#CONFOPT="--disable-xquartz --disable-launchd --enable-kdrive --disable-xsdl --enable-xnest --enable-xvfb"
#CONFOPT="-disable-glx"

MESA="$(pwd)/../Mesa-6.5.2"
#MESA="$(pwd)/../Mesa-7.0.2"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="/opt/local/bin/gmake"
MAKE_OPTS="-j5"
 
export PKG_CONFIG="/usr/local/bin/pkg-config"

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA -D__DARWIN__"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA -D__DARWIN__"

strip_finkmp() {
        local OIFS=$IFS
        local d
        IFS=:                                
        for d in ${@} ; do
                if [[ "${d}" == "${d#/opt/local}" && "${d}" == "${d#/sw}" ]] ; then
                        echo -n "${d}:"
                fi
        done
        echo
        IFS=$OIFS
}

export PATH="/usr/X11/bin:$(strip_finkmp ${PATH})"
export CPLUS_INCLUDE_PATH="/usr/X11/include:$(strip_finkmp ${CPLUS_INCLUDE_PATH})"
export C_INCLUDE_PATH="/usr/X11/include:$(strip_finkmp ${C_INCLUDE_PATH})"
export OBJC_INCLUDE_PATH="/usr/X11/include:$(strip_finkmp ${OBJC_INCLUDE_PATH})"
export PKG_CONFIG_PATH="/usr/X11/lib/pkgconfig:$(strip_finkmp ${PKG_CONFIG_PATH})"

export ACLOCAL="aclocal -I /usr/X11/share/aclocal"

die() {
	echo "${@}" >&2
	exit 1
}

docomp() {
	${CONFIGURE} --prefix=/usr/X11 --mandir=/usr/X11/man --with-mesa-source="${MESA}" ${CONFOPT} --disable-dependency-tracking --enable-maintainer-mode --with-launchagents-dir=/System/Library/LaunchAgents || die "Could not configure xserver"
	${MAKE} clean || die "Unable to make clean"
	${MAKE} ${MAKE_OPTS} || die "Could not make xserver"
}

doinst() {
	${MAKE} install DESTDIR="$(pwd)/../dist.a" || die "Could not install xserver"
}

dosign() {
	/opt/local/bin/gmd5sum $1 > $1.md5sum
	/opt/local/bin/gpg2 -b $1
}

dodist() {
	${MAKE} dist
	cp hw/xquartz/xpr/Xquartz Xquartz-$1
	bzip2 Xquartz-$1
	dosign Xquartz-$1.bz2 
	dosign xorg-server-$1.tar.bz2
}

docomp
doinst
[[ -n $1 ]] && dodist $1

#!/bin/bash

CONFIGURE="./autogen.sh"
#CONFIGURE="./configure"
#CONFOPT="--enable-xnest --enable-xvfb"
#CONFOPT="--disable-xquartz --enable-kdrive --disable-xsdl --enable-xnest --enable-xvfb"
#CONFOPT="-disable-glx"

MESA="$(pwd)/../Mesa-6.5.2"
#MESA="$(pwd)/../Mesa-7.0.2"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="gmake"
MAKE_OPTS="-j3"

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"

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
	${CONFIGURE} --prefix=/usr/X11 --mandir=/usr/X11/man --with-mesa-source="${MESA}" ${CONFOPT} --disable-dependency-tracking || die "Could not configure xserver"
	${MAKE} clean || die "Unable to make clean"
	${MAKE} ${MAKE_OPTS} || die "Could not make xserver"
}

doinst() {
	${MAKE} install DESTDIR="$(pwd)/../$(basename $(pwd)).dest" || die "Could not install xserver"
}

dosign() {
	gmd5sum $1 > $1.md5sum
	gpg2 -b $1
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

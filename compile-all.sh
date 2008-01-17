# git versions:
# xauth post 1.0.2 - 2007.12.11
# xinit post 1.0.7 - 2008.01.04
# lndir post 1.0.1 - 2007.12.11
# libxtrans post 1.0.4 - 2007.12.11
# x11proto post 1.0.11 - 2007.12.11
# libX11 post 1.1.3 - 2008.01.04
# libXfont post 1.3.1 - 2008.01.17

# Not x.org maintained:
# xterm 229 ftp://invisible-island.net/xterm/xterm-229.tgz

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="/opt/local/bin/gmake"
MAKE_OPTS="-j5"

export PKG_CONFIG="/usr/local/bin/pkg-config"

rootdir="$(pwd)"
DESTDIR="$(pwd)/dist"

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

fetch_source() {
	local d=$1
	local s
	cd ${rootdir} || die "Could not change to ${rootdir}"

	if curl -LO ftp://ftp.x.org/pub/current/src/everything/${d}.tar.bz2 ; then
		tar -xjvf ${d}.tar.bz2 || die "Failed to extract ${d}.tar.bz2"
		return 0
	fi

	for s in lib proto app data doc driver font testdir util xserver ; do
		git-clone git://anongit.freedesktop.org/git/xorg/${s}/${d} && break
	done

	# Fallback to pub/individual
	for s in lib proto app data doc driver font testdir util xserver ; do
		curl -LO ftp://ftp.x.org/pub/individual/${s}/${d}.tar.bz2 && break
	done

	if [[ -f ${d}.tar.bz2 ]] ; then
		tar -xjvf ${d}.tar.bz2 || die "Failed to extract ${d}.tar.bz2"
		return 0
	fi
}

doinst() {
	local d=$1
	shift
	[[ -d "${rootdir}/${d}" ]] || fetch_source ${d}
	cd ${rootdir}/${d} || die "unable to find source for ${d}"
	${MAKE} clean
	local CONFIGURE="./configure"
	[[ -f ${CONFIGURE} ]] || CONFIGURE="./autogen.sh"
	${CONFIGURE} --prefix=/usr/X11 --mandir=/usr/X11/man --disable-dependency-tracking "${@}" || die "Configure of ${d} failed."
	${MAKE} ${MAKE_OPTS} || die "Compile of ${d} failed."
	${MAKE} install DESTDIR="${DESTDIR}" || die "Install of ${d} failed."
}

# Protos
for d in compositeproto-0.4 damageproto-1.1.0 glproto-1.4.9 inputproto-1.4.2.1 randrproto-1.2.1 renderproto-0.9.3 x11proto; do
	doinst $d
done

# Apps
for d in xauth lndir xfs-1.0.5; do
	doinst $d
done

doinst xinit --with-launchagents-dir=/System//Library/LaunchAgents

doinst xterm-229 --enable-wide-chars --enable-luit --enable-256-color --enable-logging --enable-load-vt-fonts

# Libs need x86_64 and ppc64
export CFLAGS="${CFLAGS} -arch x86_64 -arch ppc64"

for d in pixman-0.9.6 libXfont ; do
	doinst $d --disable-static
done

doinst libxtrans
doinst libX11 --disable-xf86bigfont --without-xcb --disable-static

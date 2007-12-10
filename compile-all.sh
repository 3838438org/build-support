# git versions from 2007.12.09:
# xauth post 1.0.2
# xinit post 1.0.7
# lndir post 1.0.1

export CFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"
export LDFLAGS="-Wall -O2 -arch i386 -arch ppc -pipe -DNO_ALLOCA"

# Parallel Make.  Change $MAKE if you don't have gmake installed
MAKE="/opt/local/bin/gmake"
MAKE_OPTS="-j3"

export PKG_CONFIG="/opt/local/bin/pkg-config"

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

# It is neccessary to sanitize PATH since pixman looks for gtk-config
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

doinst() {
	local d=$1
	shift
	cd ${rootdir}/${d} || die "unable to find source for ${d}"
	${MAKE} clean
	local CONFIGURE="./configure"
	[[ -f ${CONFIGURE} ]] || CONFIGURE="./autogen.sh"
	${CONFIGURE} --prefix=/usr/X11 --mandir=/usr/X11/man --disable-dependency-tracking "${@}" || die "Configure of ${d} failed."
	${MAKE} ${MAKE_OPTS} || die "Compile of ${d} failed."
	${MAKE} install DESTDIR="${DESTDIR}" || die "Install of ${d} failed."
}

# Protos
for d in compositeproto-0.4 damageproto-1.1.0 glproto-1.4.9 inputproto-1.4.2.1 randrproto-1.2.1 renderproto-0.9.3 ; do
	doinst $d
done

# Apps
for d in xauth xinit lndir xfs-1.0.5; do
	doinst $d
done

# Libs need x86_64 and ppc64
CFLAGS="${CFLAGS} -arch x86_64 -arch ppc64"

doinst pixman-0.9.6 --disable-static

# libX11-1.1.3 has libX11-apple.patch applied - see git-diff 4b91ed099554626f1ec17d5bdf7bd77ce1a70037 b57129ef324c73ee91c2a796b800c4b45f4d4855
doinst libX11-1.1.3 --disable-xf86bigfont --disable-xcb --disable-static

#!/bin/sh

. ~/src/strip.sh

unset CFLAGS OBJCFLAGS CPPFLAGS LDFLAGS C_INCLUDE_PATH OBJC_INCLUDE_PATH CPLUS_INCLUDE_PATH PKG_CONFIG_PATH

BUILDIT=~rc/bin/buildit
#BUILDIT=/usr/local/bin/buildit
#BUILDIT=./buildit

MERGE_DIRS="/"
MERGE_DIRS="${MERGE_DIRS} ${HOME}/src/freedesktop/pkg/X11"

#MACOSFORGE=LEO
MACOSFORGE=SL

TRAIN="trunk"
#TRAIN="trains/SnowLeopard"
#TRAIN="trains/SULeo"

### End Configuration ###

XPLUGIN="${XPLUGIN:-${TRAIN}}"
X11MISC="${X11MISC:-${TRAIN}}"
X11PROTO="${X11PROTO:-${TRAIN}}"
X11LIBS="${X11LIBS:-${TRAIN}}"
QUARTZWM="${QUARTZWM:-${TRAIN}}"
X11SERVER="${X11SERVER:-${TRAIN}}"
X11APPS="${X11APPS:-${TRAIN}}"
X11FONTS="${X11FONTS:-${TRAIN}}"

die() {
	echo "${@}" >&2
	exit 1
}

MACOSFORGE_LEO=NO
MACOSFORGE_SL=NO
MACOSFORGE_RELEASE=NO

if [[ "${MACOSFORGE}" == "LEO" ]] ; then
	MACOSFORGE_LEO=YES
	MACOSFORGE_RELEASE=YES
elif [[ "${MACOSFORGE}" == "SL" ]] ; then
	MACOSFORGE_SL=YES
	MACOSFORGE_RELEASE=YES
fi

export MACOSFORGE_LEO MACOSFORGE_SL MACOSFORGE_RELEASE

if [[ ${MACOSFORGE_SL} == "YES" ]] ; then
	export X11_PREFIX="/opt/X11"
	export XPLUGIN_PREFIX="/opt/X11"
	export QUARTZWM_PREFIX="/opt/X11"	
	export X11_BUNDLE_ID_PREFIX="org.macosforge.xquartz"
	export X11_APP_NAME="XQuartz"
	export LAUNCHD_PREFIX="/Library"
	export X11_PATHS_D_PREFIX="40"
fi

if [[ ${MACOSFORGE_RELEASE} == "YES" ]] ; then
	BUILDIT="${BUILDIT} -noverifydstroot"

	export MACOSFORGE_BUILD_DOCS="YES"

	export XMLTO=/opt/local/bin/xmlto
	export ASCIIDOC=/opt/local/bin/asciidoc
	export DOXYGEN=/opt/local/bin/doxygen
	export FOP=/opt/local/bin/fop
	export FOP_OPTS="-Xmx2048m -Djava.awt.headless=true"
	export GROFF=/opt/local/bin/groff
	export PS2PDF=/opt/local/bin/ps2pdf

	for f in "${XMLTO}" "${ASCIIDOC}" "${DOXYGEN}" "${FOP}" "${GROFF}" "${PS2PDF}" ; do
		[[ -z "${f}" || -x "${f}" ]] || die "Could not find ${f}"
	done
fi

if [[ "${MACOSFORGE_LEO}" == "YES" && ${XPLUGIN} == "trunk" ]] ; then
	XPLUGIN="trains/MacOSForge"
fi

if [[ "${MACOSFORGE_LEO}" == "YES" ]] ; then
	ARCH_EXEC="-arch i386 -arch ppc"
	ARCH_ALL="${ARCH_EXEC} -arch x86_64 -arch ppc64"
	export CC="/usr/bin/gcc-4.2"
	export PYTHON=/usr/bin/python2.5
	export PYTHONPATH="/usr/X11/lib/python2.5:/usr/X11/lib/python2.5/site-packages"
	export MACOSX_DEPLOYMENT_TARGET=10.5
elif [[ "${TRAIN}" == "trains/SULeo" ]] ; then
	ARCH_EXEC="-arch i386 -arch ppc"
	ARCH_ALL="${ARCH_EXEC} -arch x86_64 -arch ppc64"
else
	ARCH_EXEC="-arch i386 -arch x86_64"
	ARCH_ALL="${ARCH_EXEC}"
	if [[ "${MACOSFORGE_SL}" == "YES" ]] ; then
		export CC="/opt/llvm/bin/clang"
		#export CC="/opt/local/bin/clang"
		export PYTHON=/usr/bin/python2.6
		export PYTHONPATH="${X11_PREFIX}/lib/python2.6:${X11_PREFIX}/lib/python2.6/site-packages"
		export MACOSX_DEPLOYMENT_TARGET=10.6
	fi
fi

bit() {
	local MERGE_ROOT
	if [[ "${MERGE_DIRS/ /}" == "${MERGE_DIRS}" ]] ; then
		MERGE_ROOT="${MERGE_DIRS}"
		mkdir -p ${MERGE_ROOT}
	else
		MERGE_ROOT="$(/usr/bin/mktemp -d ${TMPDIR-/tmp}/X11dst.XXXXXX)"
	fi

	[[ -d "${MERGE_ROOT}" ]] || die
	${BUILDIT} -noverify "${@}" -merge "${MERGE_ROOT}" || die

	if [[ "${MERGE_DIRS/ /}" == "${MERGE_DIRS}" ]] ; then
		if [[ -n "${MERGE_ROOT}" && "${MERGE_ROOT}" != "/" ]] ; then
			/bin/rm -rf ${MERGE_ROOT}/usr/local
			/bin/rmdir ${MERGE_ROOT}/usr >& /dev/null
		fi
	else
		local MERGE_DIR
		echo ""
		for MERGE_DIR in ${MERGE_DIRS}; do
			echo "*** mk_x11_dist.sh ***: Merging into root: ${MERGE_DIR}" || die
			mkdir -p ${MERGE_DIR} || die
			ditto ${MERGE_ROOT} ${MERGE_DIR} || die

			if [[ -n "${MERGE_DIR}" && "${MERGE_DIR}" != "/" ]] ; then
				/bin/rm -rf ${MERGE_DIR}/usr/local
				/bin/rmdir ${MERGE_DIR}/usr >& /dev/null
			fi
		done
		rm -rf ${MERGE_ROOT}
	fi
}

#[[ $(echo /tmp/X11*.roots) = '/tmp/X11*.roots' ]] || /bin/rm -rf /tmp/X11*.roots

[[ -n ${XPLUGIN} && -d X11_Xplugin/${XPLUGIN} ]]      && bit X11_Xplugin/${XPLUGIN}    -project X11_Xplugin   ${ARCH_ALL} 
[[ -n ${X11MISC} && -d X11misc/${X11MISC} ]]          && bit X11misc/${X11MISC}        -project X11misc       ${ARCH_ALL}
[[ -n ${X11PROTO} && -d X11proto/${X11PROTO} ]]       && bit X11proto/${X11PROTO}      -project X11proto      ${ARCH_ALL}
[[ -n ${X11LIBS} && -d X11libs/${X11LIBS} ]]          && bit X11libs/${X11LIBS}        -project X11libs       ${ARCH_ALL}
[[ -n ${QUARTZWM} && -d X11_quartz_wm/${QUARTZWM} ]]  && bit X11_quartz_wm/${QUARTZWM} -project X11_quartz_wm ${ARCH_EXEC}
[[ -n ${X11SERVER} && -d X11server/${X11SERVER} ]]    && bit X11server/${X11SERVER}    -project X11server     ${ARCH_ALL}
[[ -n ${X11APPS} && -d X11apps/${X11APPS} ]]          && bit X11apps/${X11APPS}        -project X11apps       ${ARCH_ALL}
[[ -n ${X11FONTS} && -d X11fonts/${X11FONTS} ]]       && bit X11fonts/${X11FONTS}      -project X11fonts      ${ARCH_ALL}

[[ -n ${X11SERVER} ]] && echo "Remember to edit the plists"

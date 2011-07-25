PKG_DIR=${HOME}/src/freedesktop/pkg
ROOT=${HOME}/src/freedesktop/pkg/X11
SCRIPTS_DIR=${HOME}/src/freedesktop/pkg
VERSION_TXT=`defaults read ${ROOT}/Applications/Utilities/XQuartz.app/Contents/Info.plist CFBundleShortVersionString`
VERSION_TXT_SHORT=${VERSION_TXT%_*}
VERSION=`defaults read ${ROOT}/Applications/Utilities/XQuartz.app/Contents/Info.plist CFBundleVersion`

if [[ -z "${VERSION}" || -z "${VERSION_TXT}" ]] ; then
	echo "Could not determine version information from ${ROOT}/Applications/Utilities/XQuartz.app/Contents/Info.plist"
	exit 1
fi

[[ -d XQuartz-${VERSION_TXT}.pmdoc ]] && rm -rf XQuartz-${VERSION_TXT}.pmdoc
mkdir XQuartz-${VERSION_TXT}.pmdoc

for f in XQuartz.pmdoc/*.xml ; do
	sed -e "s:@@VERSION_TXT@@:${VERSION_TXT}:g" \
	    -e "s:@@VERSION_TXT_SHORT@@:${VERSION_TXT_SHORT}:g" \
	    -e "s:@@VERSION@@:${VERSION}:g" \
	    -e "s:@@PKG_DIR@@:${PKG_DIR}:g" \
	    -e "s:@@ROOT@@:${ROOT}:g" \
	    -e "s:@@SCRIPTS_DIR@@:${SCRIPTS_DIR}:g" \
	    ${f} > ${f/.pmdoc/-${VERSION_TXT}.pmdoc}
done

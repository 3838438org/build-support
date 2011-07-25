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

gcp -a XQuartz.pmdoc XQuartz-${VERSION_TXT_SHORT}.pmdoc

XML_FILES=XQuartz-${VERSION_TXT_SHORT}.pmdoc/*xml

gsed -i "s:@@VERSION_TXT@@:${VERSION_TXT}:g" ${XML_FILES}
gsed -i "s:@@VERSION_TXT_SHORT@@:${VERSION_TXT_SHORT}:g" ${XML_FILES}
gsed -i "s:@@VERSION@@:${VERSION}:g" ${XML_FILES}
gsed -i "s:@@PKG_DIR@@:${PKG_DIR}:g" ${XML_FILES}
gsed -i "s:@@ROOT@@:${ROOT}:g" ${XML_FILES}
gsed -i "s:@@SCRIPTS_DIR@@:${SCRIPTS_DIR}:g" ${XML_FILES}

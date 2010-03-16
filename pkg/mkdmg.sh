#!/bin/bash

# ./mkdmg.sh XQuartz-2.5.0_rc1.pkg

. ~/.bashrc

verString=${1%.pkg}
name=${verString%-*}

mkdir ${verString}.d
mv ${verString}.pkg ${verString}.d/${name}.pkg
hdiutil create -srcfolder ${verString}.d -format UDBZ -volname "${verString}" ${verString}.dmg
mv ${verString}.d/${name}.pkg ${verString}.pkg
rmdir ${verString}.d

dosign ${verString}.dmg

DSA=$(./sign_update.rb ${verString}.dmg sparkle_priv.pem)
SIZE=$(wc -c ${verString}.dmg | awk '{print $1}')
echo "      <item>"
if [[ "${name}" == "XQuartz" ]] ; then
echo "         <sparkle:minimumSystemVersion>10.6</sparkle:minimumSystemVersion>"
fi
echo "         <title>${verString}</title>"
echo "         <sparkle:releaseNotesLink>http://xquartz.macosforge.org/trac/wiki/ChangeLog</sparkle:releaseNotesLink>"
echo "         <pubDate>$(date)</pubDate>"
if [[ "${name}" == "XQuartz" ]] ; then
echo "         <enclosure url=\"http://xquartz.macosforge.org/downloads/SL/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
else
echo "         <enclosure url=\"http://xquartz.macosforge.org/downloads/Leopard/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
fi
echo "      </item>"

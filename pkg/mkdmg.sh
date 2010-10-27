#!/bin/bash

# ./mkdmg.sh XQuartz-2.5.0_rc2.pkg 2.5.3

. ~/.bashrc

verString=${1%.pkg}
name=${verString%-*}

mkdir ${verString}.d
mv ${verString}.pkg ${verString}.d/${name}.pkg
hdiutil create -srcfolder ${verString}.d -format UDBZ -volname "${verString}" ${verString}.dmg
mv ${verString}.d/${name}.pkg ${verString}.pkg
rmdir ${verString}.d

dosign ${verString}.dmg

#DSA=$(./sign_update.rb ${verString}.dmg sparkle_priv.pem)
DSA=$(openssl dgst -sha1 -binary < ${verString}.dmg | openssl dgst -dss1 -sign sparkle_priv.pem | openssl enc -base64)
SIZE=$(wc -c ${verString}.dmg | awk '{print $1}')
echo "      <item>"
if [[ "${name}" == "XQuartz" ]] ; then
echo "         <sparkle:minimumSystemVersion>10.6.3</sparkle:minimumSystemVersion>"
else
echo "         <sparkle:minimumSystemVersion>10.5.8</sparkle:minimumSystemVersion>"
fi
echo "         <title>${verString}</title>"
echo "         <sparkle:releaseNotesLink>http://xquartz.macosforge.org/trac/wiki/ChangeLog</sparkle:releaseNotesLink>"
echo "         <pubDate>$(date -u +"%a, %d %b %Y %T %Z")</pubDate>"
if [[ "${name}" == "XQuartz" ]] ; then
echo "         <enclosure url=\"http://xquartz.macosforge.org/downloads/SL/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
else
echo "         <enclosure url=\"http://xquartz.macosforge.org/downloads/Leopard/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
fi
echo "      </item>"

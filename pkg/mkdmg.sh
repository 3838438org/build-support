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
echo "         <sparkle:minimumSystemVersion>10.6.3</sparkle:minimumSystemVersion>"
echo "         <title>${verString}</title>"
echo "         <sparkle:releaseNotesLink>http://xquartz.org/releases/bare/${verString}.html</sparkle:releaseNotesLink>"
echo "         <pubDate>$(date -u +"%a, %d %b %Y %T %Z")</pubDate>"
echo "         <enclosure url=\"https://dl.bintray.com/xquartz/downloads/${verString}.dmg\" sparkle:version=\"$2\" sparkle:shortVersionString=\"${verString}\" length=\"${SIZE}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"${DSA}\" />"
echo "      </item>"

source './root.sh'

newPath="$ENRoot"
newXmlConfig="$newPath/depend/xml/bin/xml2-config"
oldPath=`$newXmlConfig --prefix`
oldPath=${oldPath/"/depend/xml"/""}
if [ "$newPath" != "$oldPath" ]; then
    sed -i "s:${oldPath}:${newPath}:g" `grep "${oldPath}" -rl $newXmlConfig`
fi

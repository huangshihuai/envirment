#!/bin/sh
nowPath=`pwd`
sourcePath="$nowPath/../source/nginx/"
webPath="$nowPath/../webserver/nginx"

if [ -d "$webPath" ]; then
    rm -rf "$webPath"
fi
mkdir "$webPath"
mkdir "$webPath/sbin"
mkdir 

cd "$sourcePath"

./configure -prefix=$webPath -sbin-path=
make && make install

cd "$nginxPath"

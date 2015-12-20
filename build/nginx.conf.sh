#!/bin/sh
nowPath=`pwd`
if [ -d "$webPath" ]; then
    rm -rf "$webPath"
fi

mkdir $webPath && mkdir "$webPath/sbin/" && mkdir ""

sourcePath=$(cd "$nowPath/../source/nginx/"; pwd)
webPath=$(cd "$nowPath/../webserver/nginx"; pwd)

cd "$sourcePath"
./configure -prefix=$webPath -sbin-path=
make && make install

cd "$nginxPath"

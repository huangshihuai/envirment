#!/bin/bash

localPath=`pwd`"/../.."
function checkDir() {
    # 检查curl文件
    local sources=`cat "../config/curl_config" | grep sources`
    local sources=`echo $sources | cut -d ':' -f 2`
    local dependSource="$localPath""$sources"
    if [ ! -d $localPath ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    curlFile=$(cd $dependSource; pwd)
    getOpensslConfig $localPath
}

function makeInstall() {
    cd $curlFile
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
    fi
    echo "install curl"
    ./buildconf >/dev/null 2>&1
    ./configure --with-zlib \
        --with-ssl
    if [ ! -f "Makefile" ]; then
        echo "not fount Makefile"
        exit
    fi
    sudo make clean
    make
    make install
    echo "install curl ok"
}
checkDir
makeInstall

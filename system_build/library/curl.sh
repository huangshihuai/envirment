#!/bin/bash

localPath=`pwd`"/../.."
function getOpensslConfig() {
    local install=`cat "../config/openssl_config" | grep install`
    local install=`echo $install | cut -d ':' -f 2`   
    opensslInstall="$localPath""$install"
    if [ ! -d "$opensslInstall" ];then
        echo "openssl install path not fount: $opensslInstall"
        exit
    fi
    opensslInstall=$(cd "$opensslInstall"; pwd)
    opensslLib="$opensslInstall/lib"
    if [ ! -d "$opensslLib" ];then
        echo "openssl lib path not fount: $opensslInstall/lib"
        exit
    fi
    opensslLib=$(cd "$opensslLib"; pwd)
}

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

function delCurlDir() {
    local install=`cat "../config/curl_config" | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    curlInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $curlFile
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
    fi
    echo "install curl"
    ./buildconf >/dev/null 2>&1
    ./configure --prefix="$curlInstall" \
        --with-zlib \
        --with-ssl="$opensslLib"
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
delCurlDir
makeInstall

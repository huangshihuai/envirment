#!/bin/bash

localPath=`pwd`
# 安装目录
opensslInstall=""
# 文件路径
opensslFile=""

function checkDir() {
    local sources=`cat ./config/openssl_config | grep sources`
    local sources=`echo $sources | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo 'this config is null'
        exit
    fi
    local dependSource="$localPath/..$sources"
    if [ ! -d $localPath ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    opensslFile=$(cd $dependSource; pwd)
}

function delOpensslDir() {
    local install=`cat ./config/openssl_config | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath/..$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    opensslInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $opensslFile
    if [ -f "Makefile" ]; then
         rm "Makefile"
     fi
    ./config --prefix="$opensslInstall" \
        --openssldir="$opensslInstall/ssl"
    ./Configure
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean && make && make install
    cd $localPath
}

checkDir
delOpensslDir
makeInstall

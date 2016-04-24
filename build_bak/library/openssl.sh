#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
opensslInstall=""
# 文件路径
opensslFile=""
config=../config/openssl_config

function checkDir() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo $sources | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo 'this config is null'
        exit
    fi
    local dependSource="$localPath""$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
        exit
    fi
    opensslFile=$(cd $dependSource; pwd)
}

function makeInstall() {
    cd $opensslFile
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        rm "Makefile"
     fi
    ./config
    ./Configure
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean
    make
    make install
}

checkDir
makeInstall

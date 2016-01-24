#!/bin/bash

localPath=`pwd`
# 安装目录
opensslInstall=""
# 文件路径
opensslFile=""

function checkDir() {
    local dependSource="$localPath/../source/depend/openssl"
    if [ ! -d $localPath ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    opensslFile=$(cd $dependSource; pwd)
}

function delOpensslDir() {
    local dependInstall="$localPath/../depend/openssl"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    opensslInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $opensslFile
    if [ -f "Makefile" ]; then
         rm MakeFile
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

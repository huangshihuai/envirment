#!/bin/bash

# 引入 openssl 文件
source ./openssl.sh

function checkDir() {
    # 检查curl文件
    local dependSource="$localPath/../source/depend/curl"
    if [ ! -d $localPath ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    curlFile=$(cd $dependSource; pwd)
    # 检查openssl是否安装
    if [ ! -d "$opensslInstall" ]; then
        echo "openssl install path not fount: $opensslInstall"
        exit
    fi
    # 检查openssl库文件
    if [ ! -d "$opensslInstall/lib" ]; then
        echo "openssl lib path not fount: $opensslInstall/lib"
        exit
    fi
    opensslLib=$(cd "$opensslInstall/lib"; pwd)
}

function delCurlDir() {
    local dependInstall="$localPath/../depend/curl"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    curlInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $curlFile
    if [ -f "Makefile" ]; then
        rm Makefile
    fi
    ./buildconf
    ./configure --prefix="$curlInstall" \
        --with-zlib \
        --with-ssl="$opensslLib"
    if [ ! -f "Makefile" ]; then
        echo "not fount Makefile"
        exit
    fi
    sudo make clean && make && make install
    cd $localPath
}

checkDir
delCurlDir
makeInstall

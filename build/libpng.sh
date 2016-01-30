#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="./config/libpng_config"

if [ -n "$1" ]; then
    if [ -f "$s1" ]; then
        config="$1"
    fi
fi

function checkFile() {
    if [ ! -f "$1" ]; then
        echo "'$1' file not fount"
        exit
    fi
}

function checkDir() {
    if [ ! -d "$1" ]; then
        echo "'$1' dir not fount"
    fi
}

function checkStrIsNull() {
    if [ -z "$1" ]; then
        echo "this config is null"
        exit
    fi
}

function checkZlib() {
    local zlibConfig="./config/zlib_config"
    checkFile $zlibConfig
    local zlib=`cat "$zlibConfig" | grep install`
    checkStrIsNull $zlib
    local zlib=`echo "$zlib" | cut -d ':' -f 2`
    checkStrIsNull $zlib
    local zlib="$localPath/..$zlib"
    checkDir "$zlib"
    zlibInstall=$(cd "$zlib"; pwd)
}

function checkSource() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo "$sources" | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo 'this config is null'
        exit
    fi
    local dependSource="$localPath/..$sources"
    if [ ! -d $localPath ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    File=$(cd $dependSource; pwd)
}

function installProduct() {
    local install=`cat "$config" | grep install`
    local install=`echo "$install" | cut -d ':' -f 2`
    local dependInstall="$localPath/..$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    Install=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
     cd $File
     if [ -f "Makefile" ]; then
         sudo make clean
         sudo rm "Makefile"
     fi
     ./configure --prefix="$Install" \
         --enable-shared \
         --with-zlib-prefix="$zlibInstall"
     sudo make clean && make && make install
     cd $localPath
 }

checkZlib
checkSource
installProduct
makeInstall

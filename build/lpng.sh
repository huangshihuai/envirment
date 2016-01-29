#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="./config/lpng_config"

if [ -n "$1" ]; then
    if [ -f "$s1" ]; then
        config="$1"
    fi
fi

function checkDir() {
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

function delOpensslDir() {
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
     # 获取makefile文件路径
     local makePath=`cat "$config" | grep makeFilePath`
     local makePath=`echo "$makePath" | cut -d ':' -f 2`
     cd $File
     if [ -f "Makefile" ]; then
         sudo make clean
         sudo rm "Makefile"
     fi
     if [ ! -f "$makePath" ];then
         echo "not fount makefile:$makePath"
         exit
     fi
     cp "$makePath" "./Makefile"
     sudo make clean && make && make install DESTDIR="$Install"
     cd $localPath
 }

checkDir
delOpensslDir
makeInstall

#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
Install=""
# 文件路径
File=""

config="../config/zlib_config"

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
    File=$(cd $dependSource; pwd)
}

function makeInstall() {
    cd $File
    if [ -f "Makefile" ]; then
        sudo make clean
        sudo rm "Makefile"
     fi
    ./configure
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    make
    make install
}

checkDir
makeInstall
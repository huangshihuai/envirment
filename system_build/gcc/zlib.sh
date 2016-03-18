#!/bin/bash

# 文件路径
File=""

config="../config/zlib_config"

function checkDir() {
    local localPath="`pwd`/../../"
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
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
     fi
     echo "install zlib"
    ./configure #>/dev/null 2>&1
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean  #>/dev/null 2>&1
    make #>/dev/null 2>&1
    make install #>/dev/null 2>&1
    echo "install zlib ok"
}

checkDir
makeInstall

#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
t1libInstall=""
# 文件路径
t1libFile=""
config=../config/t1lib_config

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
    t1libFile=$(cd $dependSource; pwd)
}

function makeInstall() {
    cd $t1libFile
    if [ -f "Makefile" ]; then
        sudo make clean
        rm "Makefile"
     fi
     ./configure
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make without_doc
     make install 
}
checkDir
makeInstall

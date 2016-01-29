#!/bin/bash

localPath=`pwd`
# 安装目录
t1libInstall=""
# 文件路径
t1libFile=""

function checkDir() {
    local sources=`cat ./config/t1lib_config | grep sources`
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
    t1libFile=$(cd $dependSource; pwd)
}

function delOpensslDir() {
    local install=`cat ./config/t1lib_config | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath/..$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    t1libInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $t1libFile
    if [ -f "Makefile" ]; then
         rm "Makefile"
     fi
    ./configure --prefix="$t1libInstall"
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean && make without_doc && make install
    cd $localPath
}

checkDir
delOpensslDir
makeInstall

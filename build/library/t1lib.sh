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

function delOpensslDir() {
    local install=`cat "$config" | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    t1libInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $t1libFile
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        rm "Makefile"
     fi
     echo "install t1lib"
     ./configure --prefix="$t1libInstall" >/dev/null 2>&1
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make clean >/dev/null 2>&1
     make without_doc >/dev/null 2>&1
     make install >/dev/null 2>&1
     echo "install t1lib ok"
}

checkDir
delOpensslDir
makeInstall

#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
Install=""
# 文件路径
File=""

config=../config/freetype_config

if [ -n "$1" ]; then
    if [ -f "$s1" ]; then
        config="$1"
    fi
fi

function checkDir() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo "$sources" | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo "this config is null"
        exit
    fi
    local dependSource="$localPath""$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
        exit
    fi
    File=$(cd $dependSource; pwd)
}

function delOpensslDir() {
    local install=`cat "$config" | grep install`
    local install=`echo "$install" | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    Install=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
     cd $File
     if [ -f "Makefile" ]; then
         sudo make clean >/dev/null 2>&1
     fi
     echo "install freetype"
     ./configure --prefix="$Install" --enable-shared >/dev/null 2>&1
     sudo make clean >/dev/null 2>&1
     make >/dev/null 2>&1
     make install >/dev/null 2>&1
     echo "install freetype Ok"
 }

checkDir
delOpensslDir
makeInstall

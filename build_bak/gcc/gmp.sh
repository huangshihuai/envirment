#!/bin/bash

localPath=`pwd`
# 安装目录
# 文件路径
File=""

config="../config/gmp_config"

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

function checkSource() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo "$sources" | cut -d ':' -f 2`
    if [ -z "$sources" ]; then
        echo 'this config is null'
        exit
    fi
    local dependSource="$localPath/..$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $localPath";
        exit
    fi
    dependSource="$dependSource/build"
    if [ -d "$dependSource" ]; then
        sudo rm -rf "$dependSource"
    fi
    mkdir "$dependSource"
    File=$(cd $dependSource; pwd)
}

function makeInstall() {
    cd "$File"
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
    fi
    echo "install gmp"
    ../configure  >/dev/null 2>&1
    sudo make clean >/dev/null 2>&1
    make >/dev/null 2>&1
    make install >/dev/null 2>&1
    echo "install gmp ok"
 }

checkSource
makeInstall

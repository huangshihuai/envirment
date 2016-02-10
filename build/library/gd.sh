#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="./config/gd_config"

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

function checkConfig() {
    checkFile "$1"
    conf="$1"
    local install=`cat "$conf" | grep install`
    checkStrIsNull $install
    local install=`echo "$install" | cut -d ':' -f 2`
    checkStrIsNull "$install"
    local install="$localPath/..$install"
    checkDir "$install"
    local gdout=$(cd "$install"; pwd)
    libgd=`cat "$conf" | grep libgd`
    checkStrIsNull "$libgd"
    libgd=${libgd//.gdout/$gdout}
    libgd=`echo "$libgd" | cut -d ':' -f 2`
}

function getDepend() {
    withGd=""
    local configs="jpeg_config png_config freetype_config tiff_config"
    local config=""
    for config in $configs
    do
        checkConfig "./config/$config"
        withGd="${withGd}"" ""${libgd}"
    done
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
     ./bootstrap.sh
     echo $Install
     echo $withGd
     exit
     ./configure --prefix="$Install" --with-xpm $withGd
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make clean && make && make install
     cd $localPath
}

source './export_gcc.sh'
getDepend
checkSource
installProduct
makeInstall

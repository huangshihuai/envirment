#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="./config/mpfr_config"

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
    local out=$(cd "$install"; pwd)
    libwith=`cat "$conf" | grep libwith`
    checkStrIsNull "$libwith"
    libwith=${libwith//.out/$out}
    libwith=`echo "$libwith" | cut -d ':' -f 2`
    checkStrIsNull $libwith
}

function getDepend() {
    withConf=""
    local configs="gmp_config"
    local config
    for config in $configs
    do
        checkConfig "./config/gmp_config"
        withConf="${withConf}"" ""${libwith}"
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
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
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
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
     fi
     echo "install mpfr"
     ./configure --prefix="$Install" $withConf >/dev/null 2>&1
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make clean >/dev/null 2>&1
     make >/dev/null 2>&1
     make install >/dev/null 2>&1l
     echo "install mpfr ok"
}

getDepend
checkSource
installProduct
makeInstall

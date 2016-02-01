#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="./config/gcc_config"

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
        echo "this str is null"
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
    exportLibraryPath "$out"
}

function exportLibraryPath() {
    checkStrIsNull "$1"
    local libPath="$1/lib"
    checkDir "$libPath"
    libPath=$(cd "$libPath"; pwd)
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$libPath"
    export LD_LIBRARY_PATH
}

function getDepend() {
    withConf=""
    local configs="gmp_config mpfr_config mpc_config"
    local config=""
    for config in $configs
    do
        checkConfig "./config/$config"
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
    dependSource="$dependSource/build"
    if [ -d "$dependSource" ]; then
        sudo rm -rf "$dependSource"
    fi
    mkdir -p "$dependSource"
    File=$(cd $dependSource; pwd)
}

function installProduct() {
    local install=`cat "$config" | grep install`
    local install=`echo "$install" | cut -d ':' -f 2`
    local dependInstall="$localPath/..$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir -p $dependInstall
    Install=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $File
    echo `pwd`
    if [ -f "Makefile" ]; then
        sudo make clean
        sudo rm "Makefile"
     fi
     ../configure --prefix="$Install" \
         --disable-multilib \
         --enable-checking=release \
         --enable-languages=c,c++ \
         $withConf
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make clean && make -j2 && make install
     cd $localPath
}

getDepend
checkSource
installProduct
makeInstall

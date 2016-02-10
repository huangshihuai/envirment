#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
Install=""
# 文件路径
File=""

config="../config/zlib_config"

if [ -n "$1" ]; then
    if [ -f "$s1" ]; then
        config="$1"
    fi
fi

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

function delOpensslDir() {
    local install=`cat "$config" | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    Install=$(cd "$dependInstall"; pwd)
}

# 使用系统指定的gcc
function exportPath() {
    if [ ! -d '$localPath/../lib/gcc-4.9.0' ]; then
        if [ ! -d '$localPath/../depend/mpfr' ]; then
            cc=$(cd "$localPath/lib/gcc-4.9.0/bin"; pwd)
            lib=$(cd "$localPath/depend/mpc/lib"; pwd)
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$lib"
            export CC="$cc/gcc"
        fi
    fi
}

function makeInstall() {
    cd $File
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
     fi
     echo "install zlib"
    ./configure --prefix="$Install" #>/dev/null 2>&1
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean  >/dev/null 2>&1
    make >/dev/null 2>&1
    make install >/dev/null 2>&1
    echo "install zlib ok"
}

exportPath
checkDir
delOpensslDir
makeInstall

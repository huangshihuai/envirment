#!/bin/bash

localPath=`pwd`"/../.."
# 安装目录
opensslInstall=""
# 文件路径
opensslFile=""
config=../config/openssl_config

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
    opensslFile=$(cd $dependSource; pwd)
}

function delOpensslDir() {
    local install=`cat "$config" | grep install`
    local install=`echo $install | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ -d "$dependInstall" ]; then
        sudo rm -rf "$dependInstall"
    fi
    mkdir $dependInstall
    opensslInstall=$(cd "$dependInstall"; pwd)
}

function makeInstall() {
    cd $opensslFile
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        rm "Makefile"
     fi
     echo "install openssl"
    ./config --prefix="$opensslInstall" \
        --openssldir="$opensslInstall/ssl" #>/dev/null 2>&1
    ./Configure #>/dev/null 2>&1 &
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    sudo make clean >/dev/null 2>&1
    make #>/dev/null 2>&1
    make install >/dev/null 2>&1
    echo "install openssl ok"
}

checkDir
delOpensslDir
makeInstall

#!/bin/bash

localPath=`pwd`
# 安装目录
Install=""
# 文件路径
File=""

config="../config/gcc_config"

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

function makeInstall() {
    cd $File
    if [ -f "Makefile" ]; then
        sudo make clean
        sudo rm "Makefile"
    fi
    # 获取系统
    sysName=`head -n 1 /etc/issue | cut -d ' ' -f 1`
    sysName="x86_64-$sysName-linux"
    ../configure --prefix=/usr \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --enable-shared \
        --enable-threads=posix \
        --disable-checking \
        --with-system-zlib \
        --enable-libunwind-exceptions \
        --enable-libjava-multilib \
        --with-ppl \
        --with-cloog \
        --with-tune=generic \
        --with-arch_32=i686 \
        --enable-java-awt=gtk \
        --disable-multilib \
        --enable-bootstrap \
        --enable-checking=release \
        --enable-__cxa_atexit \
        --enable-checking=release \
        --enable-languages=c,c++,java \
        --build="$sysName" #>/dev/null 2>&1
    if [ ! -f "Makefile" ]; then
        echo "not fount MakeFile"
        exit
    fi
    echo "install gcc"
    sudo make clean >/dev/null 2>&1
    make -j2 #>/dev/null 2>&1
    make install 
    echo "install gcc ok"
}

checkSource
makeInstall

#!/bin/bash

localPath=`pwd`
# 文件路径
File=""

function checkSource() {
    sources="../../source/depend/cloog"
    local dependSource="$localPath/$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
        exit
    fi
    File=$(cd $dependSource; pwd)
    File="$File/build"
    if [ -d "$File" ];then
        rm -rf "$File"
    fi
    mkdir "$File"
}

function makeInstall() {
    cd $File
    if [ -f "Makefile" ]; then
        sudo make clean >/dev/null 2>&1
        sudo rm "Makefile"
     fi
     echo "install cloog"
     ../configure >/dev/null 2>&1
     if [ ! -f "Makefile" ]; then
         echo "not fount MakeFile"
         exit
     fi
     sudo make clean >/dev/null 2>&1
     make >/dev/null 2>&1
     make install >/dev/null 2>&1
     echo "install cloog ok"
}

checkSource
makeInstall

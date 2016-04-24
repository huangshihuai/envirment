#!/bin/bash

localPath=`pwd`"/../.."
# 文件路径
File=""

config=../config/mcrypt_config

function checkSource() {
    local sources=`cat "$config" | grep sources`
    local sources=`echo "$sources" | cut -d ':' -f 2`
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

function makeInstall() {
     cd $File
     if [ -f "Makefile" ]; then
         sudo make clean >/dev/null 2>&1
         sudo rm "Makefile"
     fi
     ./configure  #>/dev/null 2>&1
     sudo make clean >/dev/null 2>&1
     make #>/dev/null 2>&1
     make install >/dev/null 2>&1
 }

checkSource
makeInstall

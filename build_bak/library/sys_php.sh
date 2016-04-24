#!/bin/bash
localPath=`pwd`"/../.."
# 安装目录
Install=""
# 文件路径
File=""

config=../config/sys_php_config

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
        echo "this $1 is null"
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
    local dependSource="$localPath""$sources"
    if [ ! -d $dependSource ]; then
        echo "dir not fount: $dependSource";
        exit
    fi
    File=$(cd $dependSource; pwd)
}

function installProduct() {
    local install=`cat "$config" | grep install`
    local install=`echo "$install" | cut -d ':' -f 2`
    local dependInstall="$localPath""$install"
    if [ ! -d $dependInstall ]; then
        echo "dir not fount: $dependInstall";
        exit
    fi
    Install=$(cd "$dependInstall"; pwd)
}

function getPage() {
    # 获取需要默认安装的软件包
    local page=`cat "$config" | grep page`
    page=`echo "$page" | cut -d ':' -f 2`
    checkStrIsNull "$page"
    local oldIFS=$IFS
    IFS=","
    local arrPage=($page)
    IFS=$oldIFS
    for page in ${arrPage[@]};do
        if [ ! -d "$File/$page" ]; then
            echo "this $File/$page not fount"
            continue
        fi
        echo "install page: $page"
        makeInstall "$File/$page"
    done
}

function makeInstall() {
    checkDir "$1"
    cd $1
    if [ -d "$page-build" ]; then
        sudo rm -rf "$page-build"
    fi
    mkdir "$page-build" && cd "$page-build"
    if [ -f "Makefile" ]; then
        sudo make clean > /dev/null 2>&1
        sudo rm "Makefile" > /dev/null 2>&1
    fi
    ../configure #> /dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "configure error,this page:$page"
        return
    fi
    sudo make clean > /dev/null 2>&1
    make #>/dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "make error, this page:$page"
        return;
    fi
    sudo make install >/dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo "make install error, this page:$page"
        return
    fi
 }

checkSource
getPage
echo "install OK"

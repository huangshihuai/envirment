#!/bin/bash

localPath=`pwd`;
dependSource="$localPath/../source/depend"
source ./depend_config

#检查按依赖包路径
function checkDependencies() {
    for page in $dependPages
    do
        if [ ! -d "$dependSource/$page" ]; then
            echo "not find dependencies..."
            echo "check path: $dependSource/$page";
            exit
        fi
    done
}

# 删除编译的依赖库
function deleteCreate() {
    depend="$localPath/../depend/"
    if [ -d $depend ]; then
        echo "delete dir: $depend"
        rm -rf $depend
    fi
    echo "create dir: $depend";
    mkdir -p $depend
    depend=$(cd "$localPath/../depend/"; pwd)
}

# 安装openssl
function opensslInstall() {
    local install=$(cd "$depend/$opensslName"; pwd)
    out=
}

function curlInstall() {
    echo '7777';
}
deleteCreate
checkDependencies
opensslInstall
curlInstall


#!/bin/bash

function createDependDir() {
    if [ -d "../lib/gcc-4.9.0" ]; then
        rm -rf "../lib/gcc-4.9.0"
    fi
    mkdir -p "../lib/gcc-4.9.0"
    dependLib="$(cd '../lib/gcc-4.9.0'; pwd)"
}
dependLib="/root/envirment/lib"
function copyLib() {
    PHP_PATH=$(cd "../php"; pwd)
    PHP_BIN_LIB="$(find $PHP_PATH -type f -exec file -i '{}' \; | egrep 'x-executable; charset=binary|x-sharedlib; charset=binary' | awk -F ': ' '{print $1}')"
    PHP_BIN="$(find $PHP_PATH -type f -exec file -i '{}' \; | grep 'x-executable; charset=binary' | awk -F ': ' '{print $1}')"
    for i in "$PHP_BIN_LIB"; do
        deps="$(ldd $i | awk -F ' ' '{print $3}' | grep '.so')"
        for j in "$deps"; do
            if [ "$j" == "" ];then
                continue
            fi
            isLink="$(ls -l $j | awk -F ' -> ' '{print $2}')"
            if [ ! "$isLink"="" ]; then
                cp "$j" "$dependLib"
                continue
            fi

            fileDir=$(dirname $j)
            echo $fileDir
            #echo "$isLink"
            #cp -n "$fileDir/$isLink" "$dependLib"
        done
    done
}
#createDependDir
copyLib

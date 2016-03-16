#!/bin/bash
ROOT=$(cd '..'; pwd)

function createDependDir() {
    if [ -d "../lib/gcc-4.9.0" ]; then
        rm -rf "../lib/gcc-4.9.0"
    fi
    mkdir -p "../lib/gcc-4.9.0"
    dependLib="$(cd '../lib/gcc-4.9.0'; pwd)"
}
function copyLib() {
    cp /lib64/ld-linux-x86-64.so.2 "$dependLib"
    PHP_PATH=$(cd "../php"; pwd)
    PHP_BIN_LIB="$(find $PHP_PATH -type f -exec file -i '{}' \; | egrep 'x-executable; charset=binary|x-sharedlib; charset=binary' | awk -F ': ' '{print $1}')"
    PHP_BIN="$(find $PHP_PATH -type f -exec file -i '{}' \; | grep 'x-executable; charset=binary' | awk -F ': ' '{print $1}')"
    for i in $PHP_BIN_LIB; do
        deps="$(ldd $i | awk -F ' ' '{print $3}' | grep '.so')"
        for j in $deps; do
            if [ "$j" = "" ]; then
                continue
            fi
            cp -n "$j" "$dependLib"
        done
    done
    echo "ROOT=$ROOT"> "$ROOT/bin/config/php_config"
    for i in $PHP_BIN; do
        echo "$i" >> "$ROOT/bin/config/php_config"
#        /root/envirment/bin/patchelf --set-rpath /root/envirment/lib/gcc-4.9.0 --force-rpath "$i"
#        /root/envirment/bin/patchelf --set-interpreter /root/envirment/lib/gcc-4.9.0/ld-linux-x86-64.so.2 "$i"
    done
}
createDependDir
copyLib

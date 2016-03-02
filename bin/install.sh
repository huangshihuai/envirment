#!/bin/bash

PHP_VERSION=5.6.17
PHP_CONF=${}

ROOT="$(cd ..; pwd)"
LIBPATH="$ROOT/lib/gcc-4.9.0"
PHP="$ROOT/php/"
patchelf="$ROOT/bin/patchelf" 
new_linker="$LIBPATH/ld-linux-x86-64.so.2"
if [ ! -f "$new_linker" ]; then
    echo "<not found $new_linker>"
    exit
fi
oldRoot=`cat ./config/php_config | grep ROOT | cut -d '=' -f 2`
if [[ "$oldRoot" != "$ROOT" ]]; then
    echo "替换数据-路径替换"
    sed -i "s:${oldRoot}:${ROOT}:g" `grep "${oldRoot}" -rl ./config/php_config`
fi
for line in `cat ./config/php_config`; do
    if [ ! -f "$line" ]; then
        continue
    fi
    old_linker=`$patchelf --print-interpreter $line`
    if [[ "$old_linker" == "$new_linker" ]];then
        continue
    fi
    $patchelf --set-rpath "$LIBPATH" --force-rpath "$line"
    $patchelf --set-interpreter "$new_linker" "$line"
done

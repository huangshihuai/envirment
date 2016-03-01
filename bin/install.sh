#!/bin/bash

ROOT="$(cd ..; pwd)"
LIBPATGH="$ROOT/lib/gcc-4.9.0"
PHP="$ROOT/php/"
patchelf="$ROOT/bin/patchelf"
new_linker="$LIBPATGH/ld-linux-x86-64.so.2"
if [ ! -f "$new_linker" ]; then
    echo "not found $new_linker"
    exit
fi
oldRoot=`cat ./config/php_config | grep ROOT | cut -d '=' -f 2`
echo $oldRoot
exit
for line in `cat ./config/php_config`; do
    if [ ! -f "$line" ]; then
        echo "not fount: $line"
        continue
    fi
    old_linker=`$patchelf --print-interpreter $line`
    if [[ "$old_linker" == "$new_linker" ]];then
        continue
    fi
    echo $patchelf
    echo $new_linker
    echo $line
    $patchelf --set-interpreter $new_linker $line
done

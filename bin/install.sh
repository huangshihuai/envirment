#!/bin/bash

ROOT="$(cd ..; pwd)"
LIBPATGH="$ROOT/lib/gcc-4.9.0"
patchelf="$ROOT/bin/patchelf"
new_linker="$LIBPATGH/ld-linux-x86-64.so.2"
if [ ! -f "$new_linker" ]; then
    echo "not found $new_linker"
    exit
fi
for line in `cat ./config/php_config`; do
    old_linker=`$patchelf --print-interpreter $line`
    if [[ "$old_linker" == "$new_linker" ]];then
        continue
    fi
    $patchelf --set-interpreter $new_linker $line
done

# 这个脚本是在php或者nginx编译后执行的
# 保证移植的可靠性
ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
ENV_LIB_PATH=$ENV_ROOT/lib/gcc-4.9.0
patchelf=$ENV_ROOT/bin/patchelf

move_lib() {
    params=$1
    for param in ${params[*]}; do
        if [ $ii -eq 1 ]; then
            continue
        fi
        fileName=$ENV_ROOT/$param
        if [[ ! -f $fileName ]]; then
            continue;
        fi
        now_set_path='$ORIGIN:$ORIGIN/../lib:$ORIGIN/../../lib/gcc-4.9.0'
        old_set_path=`$patchelf --print-rpath "$fileName"`
        if [[ $now_set_path == $old_set_path ]]; then
            continue
        fi
        ld=`$patchelf --print-interpreter $fileName`
        if [[ ! -f $ld ]]; then
            continue;
        fi
        ldDir=$(readlink -f `dirname $ld`)
        if [[ $ldDir != $ENV_LIB_PATH ]]; then
            cp $ld $ENV_LIB_PATH
        fi

        deps=`ldd $fileName | awk -F ' ' '{print $3}' | grep '.so'`
        for dep in ${deps};do
            if [[ ! -f $dep ]]; then
                continue;
            fi
            cp $dep $ENV_LIB_PATH
        done
        now_path=$(readlink -f `dirname $fileName`)
        cd $now_path
        $patchelf --set-rpath "$now_set_path" --force-rpath "$fileName"
        #$patchelf --set-rpath './../../lib/gcc-4.9.0' --force-rpath "$fileName"
    done
}

install() {
    if [[ ! -d $ENV_LIB_PATH ]]; then
        mkdir -p $ENV_LIB_PATH
    fi
    local configs=`ls $ENV_ROOT/bin/config/*/config.sh`
    for config in ${configs[*]}; do
        source $config
        move_lib "${binary_files[*]}"
    done
}

install

ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
ENV_LIB_PATH=$ENV_ROOT/lib/gcc-4.9.0
patchelf=$ENV_ROOT/bin/patchelf

move_lib() {
    params=$1
    for param in ${params[*]}; do
        fileName=$ENV_ROOT/$param
        if [[ ! -f $fileName ]]; then
            continue;
        fi
        ld=`$patchelf --print-interpreter $fileName`
        cp -n $ld $ENV_LIB_PATH

        deps=`ldd $fileName | awk -F ' ' '{print $3}' | grep '.so'`
        for dep in ${deps};do
            cp -n $dep $ENV_LIB_PATH
        done

        now_path=$(readlink -f `dirname $fileName`)
        cd $now_path
        $patchelf --set-rpath '$ORIGIN:$ORIGIN/../lib:$ORIGIN/../../lib/gcc-4.9.0' --force-rpath "$fileName"
        #$patchelf --set-rpath './../../lib/gcc-4.9.0' --force-rpath "$fileName"
    done
}

install() {
    if [[ -d $ENV_LIB_PATH ]]; then
        mkdir -p $ENV_LIB_PATH
    fi
    local configs=`ls $ENV_ROOT/bin/config/*/config.sh`
    for config in ${configs[*]}; do
        source $config
        move_lib "${binary_files[*]}"
    done
}

install

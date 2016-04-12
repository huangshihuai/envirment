# 这个脚本是在php或者nginx编译后执行的
# 保证移植的可靠性
# 虽然修改了每个可执行文件的依赖库路径,但有些so文件还是会依赖其他的文件,
# 在不同体系(系统不同)中的所依赖的库不一定存在,
# 例如在执行iconv_open函数时,Ubuntu需要到/usr/lib/x86_64-linux-gnu/gconv下读取
# 而在CentOs需要在/usr/lib64/gconv目录下读取.所以设置GCONV_PATH可以用来设置访问目录
# GCONV_PATH 可以相对路径

ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
ENV_LIB_PATH=$ENV_ROOT/lib/gcc-4.9.0
ENV_GCONV_PATH=$ENV_LIB_PATH/gconv
patchelf=$ENV_ROOT/bin/patchelf
sys_GCONV_PATH=

check_system() {
    sysName=`head -n 1 /etc/issue | cut -d ' ' -f 1`
    if [[ "$sysName"=="CentOs" ]]; then
        $sys_GCONV_PATH="/usr/lib64/gconv"
    else
        $sys_GCONV_PATH="/usr/lib/x86_64-linux-gnu/gconv"
    fi
    if [[ ! -d $sys_GCONV_PATH ]]; then
        echo "gcnov not fount: $sys_GCONV_PATH"
        exit
    fi
}

copy_gcnov() {
    check_system
    if [[ -d $ENV_GCONV_PATH ]]; then
        mkdir -p $ENV_GCONV_PATH
    fi
    cp -r $sys_GCONV_PATH/* $ENV_GCONV_PATH
}

move_lib() {
    params=$1
    for param in ${params[*]}; do
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

copy_gcnov
install

process_text(){
    if grep -lI "$old_dir" $1 >/dev/null; then
        sed -i "s+$old_dir+$ENV_ROOT+g" $1
    fi
}
process_serialized() {
    export PHP_INI_SCAN_DIR='/not_exists'
    local php=$ENV_ROOT/php/bin/php
    grep -P '^#' $1 >$1.new || true # 对php/etc/pear.php特殊处理
    cat $1 | grep -Pv '^#' | $php -r '
        $a=file_get_contents("php://stdin");
        $a=unserialize($a);
        echo "<?php\n echo serialize(";
        var_export($a);
        echo ");";
    ' | sed "s+$old_dir+$ENV_ROOT+g" | $php >> $1.new
    mv $1.new $1

}

process_binary() {
    local patchelf=$ENV_ROOT/bin/patchelf
    local new_linker=$ENV_LIB_PATH/ld-linux-x86-64.so.2
    local old_linker=`$patchelf --print-interpreter $1`
    if [[ $old_linker == $new_linker ]]; then
        return;
    fi
    $patchelf --set-interpreter $new_linker $1
    binary_installed="$binary_installed `basename $1`"
}
apply_files() {
    local param=$1
    for dir in ${param[*]}; do
        dir=$ENV_ROOT/$dir
        if [[ -d $dir ]]; then
            local files=`find $dir -type f`
        elif [[ -f $dir ]]; then
            $2 $dir
        fi
    done
}

init_env() {
    ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
    ENV_LIB_PATH=$ENV_ROOT/lib/gcc-4.9.0
    ENV_GCONV_PATH=$ENV_LIB_PATH/gconv
}

install() {
    binary_installed=''
    package_installed=''
    local configs=`ls $ENV_ROOT/bin/config/*/config.sh`

    for config in ${configs[*]}; do
        local package=$(basename `dirname $config`)
        local binary_files=
        local text_files=
        local serialized_files=
        old_dir=
        source $config
        apply_files "${binary_files[*]}" process_binary
        if [[ $old_dir == $ENV_ROOT ]]; then
            continue;
        fi
        apply_files "${text_files[*]}" process_text
        apply_files "${serialized_files[*]}" process_serialized
        process_text $config
        package_installed="$package_installed $package"
    done
    if [[ -n $package_installed ]]; then
        echo "On first use, install package:$package_installed" >&2
    fi
    if [[ -n $binary_installed ]]; then
        echo "On first use, install binary:$binary_installed" >&2
    fi
}

not() {
    if $@; then
        return 1
    else
        return 0
    fi
}

wait_for(){
    local try=$1
    shift
    for (( ;try>0;try-- )); do
        if $@ ; then
            return 0
        fi
        echo -n .
        sleep 1
    done
    return 1
}

process_exists() {
    local pid=$1
    local bin=$2
    if [[ -d /proc/$pid ]]; then
        # 获取执行文件的路径
        local exec=`readlink -f /proc/$pid/exe`
        if [[ $exe == $bin ]]; then
            return 0
        fi
        if [[ ! -e $exe ]]; then
            return 0
        fi
    fi
    return 1
}

init_env
install

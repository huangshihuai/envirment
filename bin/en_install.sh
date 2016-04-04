process_text(){
    if grep -lI "$old_dir" $1 >/dev/null; then
        sed -i "s+$old_dir+$ENV_ROOT+g" $1
    fi
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
process_macro(){
    if ! grep -lI '#IF' $1 >>/root/tp; then
        return;
    fi
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
        local macro_files=
        old_dir=
        macros=
        source $config
        apply_files "${binary_files[*]}" process_binary
        if [[ $old_dir == $ENV_ROOT ]]; then
            continue;
        fi
        apply_files "${text_files[*]}" process_text
        #apply_files "${macro_files[*]}" process_macro
    done
}

init_env
install

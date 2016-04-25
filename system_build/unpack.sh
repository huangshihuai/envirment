init_env() {
    ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
    packName=envirment.tar
}

exec_unpack(){
    cd $ENV_ROOT
    unpack_files=
    source $ENV_ROOT/system_build/config/unpack_config
    filenames=
    for item in ${unpack_files[*]}; do
        if [ ! -d $ENV_ROOT/$item ]; then
            echo "dir path: "$ENV_ROOT/$item" not fount."
            exit
        fi
        filenames=$filenames" "$item
    done
    tar -zcvf ${packName} $filenames
}

init_env
exec_unpack

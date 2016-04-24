#!/bin/bash
nginx_dir=
nginx_cache_dir=
# 设置nginx用户,所有组
ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
source $ENV_ROOT/bin/config/nginx/config.sh
source $ENV_ROOT/bin/config/nginx/install
webPath=$ENV_ROOT/$webserver
sourcePath=$(cd "$ENV_ROOT/source/nginx"; pwd)
function userGroup(){
    echo -n "输入user:"
    read user
    echo -n "输入group:"
    read group
    echo -n "user:$user\0group:$group\n如果输入没错请按回车,如果输入错误请Ctrl+C:"
    read temp
}
# 创建nginx所需要的文件
function createDir() {
    if [ ! -d $webPath ]; then
        mkdir -p $webPath
    fi
    # 创建nginx基本目录
    for item in ${nginx_dir[*]}; do
        if [ ! -d $webPath/$item ];then
            mkdir -p $webPath/$item
        fi
    done

    for item in ${nginx_cache_dir[*]}; do
        if [ ! -d $webPath/$item ]; then
            mkdir -p $webPath/$item
        fi
    done
}

function moveDir() {
    buildPath=$(cd $sourcePath/..; pwd)
    for item in ${nginx_dir[*]}; do
        if [ -d $buildPath/$item ]; then
            cp -r $buildPath/$item $webPath
            rm -rf $buildPath/$item
        fi
    done
}

# 创建必要的文件夹
createDir

openssl=$(cd "$sourcePath/../depend/openssl"; pwd)
zlib=$(cd "$sourcePath/../depend/zlib"; pwd)
pcre=$(cd "$sourcePath/../depend/pcre"; pwd)

# nginx 的其他模块
upload_progress=$(cd "$sourcePath/../depend/nginx-upload-progress-module"; pwd)
upstream_fair=$(cd "$sourcePath/../depend/nginx-upstream-fair"; pwd)
concat_module=$(cd "$sourcePath/../depend/concat_module"; pwd)
headers_more_nginx_module=$(cd "$sourcePath/../depend/headers-more-nginx-module"; pwd)

cd "$sourcePath"
# nginx-1.8.0 删除Makefile文件以及objs文件夹
sudo make clean
./configure --prefix=.. \
    --without-http_userid_module \
    --with-cc-opt=-Wno-error \
    --with-ipv6 \
    --with-file-aio \
    --with-poll_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-http_stub_status_module \
    --with-md5-asm \
    --with-md5="$openssl" \
    --with-sha1-asm \
    --with-sha1="$openssl" \
    --with-openssl="$openssl" \
    --with-pcre="$pcre" \
    --with-pcre-jit \
    --with-zlib="$zlib" \
    --add-module="$upload_progress" \
    --add-module="$upstream_fair" \
    --add-module="$concat_module" \
    --add-module="$headers_more_nginx_module"
sudo make && make install
moveDir
cd $webPath/conf
cp nginx.conf-back nginx.conf
cd "$nowPath"

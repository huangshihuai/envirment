#!/bin/bash
# 设置nginx用户,所有组
ENV_ROOT=$(readlink -f `dirname $BASE_SOURCE[0]`/..)
source $ENV_ROOT/bin/config/nginx/config.sh
webPath=$ENV_ROOT/$webserver
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
    if [ -d "$webPath" ]; then
        echo "删除nginx文件:$webPath"
        sudo rm -rf "$webPath"
    fi
    # 创建nginx基本目录
    dir="$webPath $webPath/sbin/ $webPath/conf/ $webPath/cache"
    echo "创建nginx文件夹:$dir"
    mkdir $dir

    # 创建缓存文件目录
    cache=$(cd "$webPath/cache"; pwd)
    dir="$cache/client_body $cache/fastcgi $cache/proxy $cache/scgi $cache/uwsgi"
    echo "创建nginx缓存文件夹:$dir"
    mkdir $dir
}
# 设置nginx的依赖库
function setLibrary() {
    name=$1
    while [ true ]
    do
        echo -n "请输入$name 的文件路径:"
        read pathDir
        # 存在文件夹
        if [ -d "$pathDir" ];then
            echo -n "请确定文件路径:$pathDir?,重新输入'r',否则输入任意键: "
            read answer
            # 输入不等于r
            if [ "$answer" != "r" ];then
                break;
            fi
        else
            echo "\"$pathDir\"不是一个文件夹"
        fi
    done
}

# 输入用户和组
#userGroup
user=root
group=root
# 创建必要的文件夹
createDir

# 设置变量
# nginx 文件路径
sourcePath=$(cd "$ENV_ROOT/source/nginx"; pwd)
# web服务器的路径
#webPath=$(cd "$/webserver/nginx"; pwd)
# sbin 路径
sbinPath=$(cd "$webPath/sbin"; pwd)
# 配置文件路径
confPath=$(cd "$webPath/conf"; pwd)
# 存储nginx pid路径
varPath=$(cd "$ENV_ROOT/var"; pwd)
# 日志路径
logPath=$(cd "$ENV_ROOT/log"; pwd)

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
    --with-cc-opt=-Wno-error \
    --with-ipv6 \
    --without-select_module \
    --without-poll_module \
    --with-file-aio \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-http_stub_status_module \
    --without-http_ssi_module \
    --without-http_userid_module \
    --without-http_geo_module \
    --without-http_empty_gif_module \
    --without-http_map_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-md5-asm \
    --with-md5="$openssl" \
    --with-sha1-asm \
    --with-sha1="$openssl" \
    --with-openssl="$openssl" \
    --with-pcre="$pcre" \
    --with-pcre-jit \
    --with-zlib="$zlib" \
    --without-http_autoindex_module \
    --without-http_auth_basic_module \
    --without-http_browser_module \
    --without-http_limit_conn_module \
    --without-http_limit_req_module \
    --without-http_memcached_module \
    --without-http_referer_module \
    --without-http_proxy_module \
    --without-http_scgi_module \
    --without-http_split_clients_module \
    --without-http_upstream_ip_hash_module \
    --without-http_upstream_hash_module \
    --without-http_uwsgi_module \
    --add-module="$upload_progress" \
    --add-module="$upstream_fair" \
    --add-module="$concat_module" \
    --add-module="$headers_more_nginx_module"


sudo make && make install
cd "$nowPath"

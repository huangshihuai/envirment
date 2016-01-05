function setDebug() {
    echo -n "开启debug? [yes/no]:";
    while [ true ]
    do
        read answer
        if [ $answer = "no" ];then
            debug="--disable-debug"
            break
        elif [ $answer = "yes" ];then
            debug="--enable-debug"
            break
        else
            echo -n "输入:[yes/no]:"
        fi
    done
}
setDebug
dir=`pwd`
phpPath=$(cd "$dir/../php"; pwd)
cd $dir/../source/php

# 编译所有的扩展
./configure --prefix=$phpPath --sbindir=$phpPath/bin/ --with-config-file-path=$phpPath/etc/ --with-config-file-scan-dir=$phpPath/etc/ --libexecdir=$phpPath/ext/ --with-curl --with-mysql --with-zlib --with-gd --with-mcrypt --with-jpeg-dir --with-png-dir --with-xpm-dir --with-gettext --with-freetype-dir --with-bz2 --with-iconv-dir --with-libxml-dir --enable-fpm --with-fpm-user=www --with-fpm-group=www --disable-pdo --enable-mbstring --enable-sockets --enable-soap --enable-gd-native-ttf --enable-gd-jis-conv --enable-ftp --enable-zip --enable-calendar --enable-mbstring --enable-exif --enable-fd-setsize=4096 --disable-ipv6 --enable-maintainer-zts $debug

# 自定义扩展
#./configure --prefix=$phpPath --with-config-file-path=$phpPath/etc --with-curl --with-mysql --with-zlib --with-gd --with-mcrypt --with-jpeg-dir --with-png-dir --with-xpm-dir --with-gettext --with-freetype-dir --with-bz2 --with-iconv-dir --with-libxml-dir --enable-fpm --with-fpm-user=www --with-fpm-group=www --disable-pdo --enable-mbstring --enable-sockets --enable-soap --enable-gd-native-ttf --enable-gd-jis-conv --enable-ftp --enable-zip --enable-calendar --enable-mbstring --enable-exif --enable-fd-setsize=4096 --disable-ipv6 --enable-maintainer-zts $debug

make clean && make && make install
echo $s
cd $dir
# 系统自动检测是否安装,也可以自己安装指定路径
#    --with-mysql=/usr/local/mysql
#    --with-pcre-dir=/usr/local/pcre
#    ---with-zlib=/usr/local/zlib
#    ---with-zlib-dir=/usr/local/zlib
#    ---with-curl=/usr/local/curl

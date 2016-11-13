function setDebug() {
    echo -n "开启debug? [yes/no]:";
    while [ true ]
    do
        read answer
        if [ $answer = "no" ];then
            debug=""
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
#debug="--enable-debug"
dir=`pwd`
phpPath=$(cd "$dir/../php"; pwd)
depend=$(cd "$dir/../source/depend"; pwd)
cd $dir/../source/php
# 删除Makefile
if [ -f "Makefile" ]; then
    sudo make clean
    rm "Makefile"
fi

openssl=$(cd "$dir/../../depend/openssl"; pwd)
curl=$(cd "$dir/../../depend/curl"; pwd)
zlib=$(cd "$dir/../../depend/zlib"; pwd)
xml=$(cd "$dir/../../depend/xml"; pwd)
jpeg=$(cd "$dir/../../depend/jpeg"; pwd)
png=$(cd "$dir/../../depend/png"; pwd)
#xpm=$(cd "$dir/../depend/xpm"; pwd)
freetype=$(cd "$dir/../../depend/freetype"; pwd)
mcrypt=$(cd "$dir/../../depend/mcrypt"; pwd)
libmcrypt="$mcrypt"

# 编译所有的扩展
./configure --prefix=$phpPath \
    --with-config-file-path=$phpPath/etc \
    --with-config-file-scan-dir=$phpPath/etc/ext \
    --enable-bcmath \
    --enable-fpm \
    --enable-gd-native-ttf \
    --enable-mbstring \
    --enable-shmop \
    --enable-soap \
    --enable-sockets \
    --enable-sysvsem \
    --enable-pcntl \
    --enable-zip \
    --enable-ftp \
    --enable-calendar \
    --enable-exif \
    --enable-fd-setsize=4096 \
    --enable-opcache \
    --with-gd \
    --with-pear \
    --with-xmlrpc \
    --with-openssl="$openssl" \
    --with-zlib="$zlib" \
    --with-curl="$curl" \
    --with-mcrypt="$libmcrypt" \
    --with-freetype-dir=$freetype \
    --with-jpeg-dir="$jpeg" \
    --with-png-dir="$png" \
    --with-libxml-dir="$xml" \
    --with-pdo-mysql \
    --with-xpm-dir \
    --with-gettext \
    --with-iconv-dir \
    $debug

#echo 'cd '`pwd`
#echo 'run: make && make install'
if [ -f "Makefile" ]; then
    make && make install
fi
cd $dir

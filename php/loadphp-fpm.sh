set -e
source $(cd `dirname $0`/.. && pwd)/bin/en_install.sh

PHP_VERSION=5.4
PHP_CONF=${ENV_ROOT}/php/etc/php.ini
PHP_FPM_BIN=${ENV_ROOT}/php/sbin/php-fpm
PHP_FPM_CONF=${ENV_ROOT}/php/etc/php-fpm.conf
PHP_FPM_PID=${ENV_ROOT}/var/php-fpm.pid
ENV_LOG_PATH=${ENV_ROOT}/log
PHP_LOG_PATH=$ENV_LOG_PATH/php
PHP_OPTS="-c $PHP_CONF -p $ENV_ROOT/php --fpm-config $PHP_FPM_CONF"
PHP_OPTS="-c $PHP_CONF --fpm-config $PHP_FPM_CONF"
PHP_LOG_LIST="php.error.log php-fpm.log"
#PHP_INI_SCAN_DIR=${ENV_ROOT}/php/etc/ext

mstart() {
    if [ ! -f "$PHP_LOG_PATH" ]; then
        mkdir -p "$PHP_LOG_PATH"
    fi
    for i in $PHP_LOG_LIST; do
        if [ ! -f "$PHP_LOG_PATH"/$i ]; then
            touch "$PHP_LOG_PATH/$i"
        fi
        if [ ! -h "$ENV_LOG_PATH/$i" ]; then
            ln -s "php/$i" "$ENV_LOG_PATH/$i"
        fi
    done
    echo -n "start php-fpm"
    #PHP_INI_SCAN_DIR=${ENV_ROOT}/php/etc/ext $PHP_FPM_BIN $PHP_OPTS
    if GCONV_PHP=$ENV_GCOBV_PATH PHP_INI_SCAN_DIR=${ENV_ROOT}/php/etc/ext $PHP_FPM_BIN $PHP_OPTS ; then
        if wait_for 30 test -f $PHP_FPM_PID; then
            echo "done"
        else
            echo "file"
            exit 1
        fi
    else
        echo "failed"
        exit 1
    fi
}

mstop() {
    if [ ! -r $PHP_FPM_PID ]; then
        return
    fi
    local pid=`head $PHP_FPM_PID`
    if ! process_exists $pid $PHP_FPM_BIN; then
        rm $PHP_FPM_PID
        return
    fi

    if [[ $1 == "quit" ]]; then
        echo -n "shutting down php-fpm gracefully"
        kill -QUIT `cat $PHP_FPM_PID`
    else
        echo -n "shutting down php-fpm"
        kill -TERM `cat $PHP_FPM_PID`
    fi

    if wait_for 10 "not process_exists $pid $PHP_FPM_BIN"; then
        echo 'done'
    else
        echo 'failed'
        exit 1
    fi
}

case "$1" in
    start)
        mstop
        mstart
        ;;
    stop)
        mstop
        ;;
    quit)
        mstop quit
        ;;
    restart)
        mstop
        mstart
        ;;
    *)
        echo "usage $0 {start|stop|quit|restart}"
        exit 1
        ;;
esac

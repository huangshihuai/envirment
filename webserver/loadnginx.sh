#!/bin/bash

set -e

source $(cd `dirname $0`/../ && pwd)/bin/en_install.sh

NGINX_HOME=${ENV_ROOT}/webserver
NGINX_BIN=$NGINX_HOME/sbin/nginx
NGINX_LOG="access_log error_log"
PID_FILE=$ENV_ROOT/var/nginx.pid

# nginx需要加载webserver/logs/error_log和webserver/conf/nginx.conf文件
# nginx 编译采用的是相对路径,定位到nginx所在目录是必要的
cd $NGINX_HOME/sbin
nstart() {
    echo -n "starting nginx: "
    if [ ! -d "$ENV_ROOT/log/webserver" ]; then
        mkdir "$ENV_ROOT/log/webserver"
    fi

    for item in $NGINX_LOG ;do
        if [ ! -f "$ENV_ROOT/log/webserver/$item" ]; then
            touch "$ENV_ROOT/log/webserver/$item"
        fi
    done
    if GCONV_PATH=$ENV_GCONV_PATH $NGINX_BIN; then
        echo "ok"
    else
        echo "fail"
    fi
}

nstop(){
    if [[ ! -f $PID_FILE ]]; then
        return
    fi
    PID=`head $PID_FILE`
    if ! process_exists $PID $NGINX_BIN; then
        rm $PID_FILE
        return
    fi
    echo -n "stop nginx: "
    kill $PID
    if wait_for 10 "not process_exists $PID $NGINX_BIN"; then
        echo "ok"
    else
        echo 'fail'
        exit 1
    fi
}

case "$1" in
    start)
        nstop
        nstart
        ;;
    stop)
        nstop
        ;;
    restart)
        nstop
        nstart
        ;;
    reload)
        if GCONV_PATH=$ENV_GCONV_PATH $NGINX_BIN -s reload; then
            echo "reload ok"
        else
            echo "reload fail"
        fi
        ;;
    chkconfig)
        GCONV_PATH=$ENV_GCONV_PATH $NGINX_BIN -t
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|reload|chkconfig}"
        ;;
esac

#!/bin/bash

set -e

source $(cd `dirname $0`/../ && pwd)/bin/en_install.sh

NGINX_HOME=${ENV_ROOT}/webserver
NGINX_BIN=$NGINX_HOME/sbin/nginx
NGINX_LOG="access_log error_log"
PID_FILE=${ENV_ROOT}/var/nginx.pid

cd $NGINX_HOME/sbin

nstrat() {
    echo -n "starting nginx: "
    if [ ! -d "$ENV_ROOT/log/webserver" ]; then
        mkdir "$ENV_ROOT/log/webserver"
    fi

    for item in $NGINX_LOG ;do
        if [ ! -f "$ENV_ROOT/log/webserver/$item" ]; then
            touch "$ENV_ROOT/log/webserver/$item"
        fi
    done

}

set -e
source $(cd `dirname $0`/.. && pwd)/bin/en_install.sh

PHP_VERSION=5.4
PHP_CONF=${ENV_ROOT}/php/etc/php.ini
PHP_FPM_BIN

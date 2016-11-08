/***********************************************
 *
 * 这块需移植到 main/main.c下面
 */
#include "dynamic_path.h"
#include <stdlib.h>
#include <stdio.h>
#include <libgen.h>
#include <limits.h>
#include <unistd.h>

// 存储PHP安装路径
char __en_php_prefix[PATH_MAX] = {0};
char __en_pear_installdir[PATH_MAX] = {0};
char __en_php_bindir[PATH_MAX] = {0};
char __en_php_sbindir[PATH_MAX] = {0};
char __en_php_mandir[PATH_MAX] = {0};
char __en_php_libdir[PATH_MAX] = {0};
char __en_php_datadir[PATH_MAX] = {0};
char __en_php_sysconfdir[PATH_MAX] = {0};
char __en_php_localstatedir[PATH_MAX] = {0};
char __en_php_config_file_path[PATH_MAX] = {0};
char __en_php_config_file_scan_dir[PATH_MAX] = {0};

int __get_dynamic_php_prefix_path() {

    if (__en_php_prefix[0]) {
        return __en_ok_php_path;
    }
    char buffer[PATH_MAX] = {0};
    if (readlink("/proc/self/exe", buffer, PATH_MAX) < 0) {
        return __en_error_php_path_self;
    }
    // 获取php上一层目录: $path/php/bin
    if (dirname(buffer) != buffer) {
        return __en_error_php_path_bin;
    }
    // 获取到PHP目录:prefix: $path/php
    if (dirname(buffer) != buffer) {
        return __en_error_php_path_prefix;
    }
    snprintf(__en_php_prefix, PATH_MAX, "%s", buffer);
    return __en_ok_php_path;
}

char *__get_dynamic_php_mosaics_path(const char *prefix, const char *suffix, const __en_php_define type) {
    __en_path_status_type status_type = __get_dynamic_php_prefix_path();
    if (status_type != __en_ok_php_path) { 
        __en_error_msg(status_type);
    }
    char *buf = NULL;
    switch(type)
    {
        case EN_DEF_PEAR_INSTALLDIR:
            buf = __en_pear_installdir;
            break;
        case EN_DEF_PHP_PREFIX:
            return __en_php_prefix;
        case EN_DEF_PHP_BINDIR:
            buf = __en_php_bindir;
            break;
        case EN_DEF_PHP_SBINDIR:
            buf = __en_php_sbindir;
            break;
        case EN_DEF_PHP_MANDIR:
            buf = __en_php_mandir;
            break;
        case EN_DEF_PHP_LIBDIR:
            buf = __en_php_libdir;
            break;
        case EN_DEF_PHP_DATADIR:
            buf = __en_php_datadir;
            break;
        case EN_DEF_PHP_SYSCONFDIR:
            buf = __en_php_sysconfdir;
            break;
        case EN_DEF_PHP_LOCALSTATEDIR:
            buf = __en_php_localstatedir;
            break;
        case EN_DEF_PHP_CONFIG_FILE_PATH:
            buf = __en_php_config_file_path;
            break;
        case EN_DEF_PHP_CONFIG_FILE_SCAN_DIR:
            buf = __en_php_config_file_scan_dir;
            break;
        default:
            return NULL;
    }
    if (NULL == buf) {
        return NULL;
    }
    snprintf(buf, PATH_MAX, "%s%s%s", prefix, __en_php_prefix, suffix);
    return buf;
}

void __en_error_msg(const __en_path_status_type type) {

    switch (type)
    {
        case __en_error_php_path_self:
            printf("Warning: Can not get PHP executable file path.\n");
            break;
        case __en_error_php_path_bin:
            printf("Warning: PHP prefix path is truncated. Bin file not found\n");
            break;
        case __en_error_php_path_prefix:
            printf("Warning: PHP prefix path is truncated. PHP file not found\n");
            break;
        default:
            break;
    }
    return;
}

size_t __get_register_length(const char * const str) {
    return strlen(str);
}

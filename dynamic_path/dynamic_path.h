#ifndef DYNAMIC_PATH_H
#define DYNAMIC_PATH_H
#include <stdlib.h>
/**
 * 定义路径
 * 防止内存泄漏(策略选择):
 * 1、定义全局变:浪费空间
 * 2、在php_module_startup加载时new,模块结束时delete
 */
extern char __en_pear_installdir[];
extern char __en_php_include_path[];
extern char __en_php_extension_dif[];
extern char __en_php_prefix[];
extern char __en_php_bindir[];
extern char __en_php_sbindir[];
extern char __en_php_mandir[];
extern char __en_php_libdir[];
extern char __en_php_datadir[];
extern char __en_php_sysconfdir[];
extern char __en_php_localstatedir[];
extern char __en_php_config_file_path[];
extern char __en_php_config_file_scan_dir[];

/**
 * 错误信息
 */
typedef enum __en_path_status_type_enum
{
    __en_ok_php_path,           // PHP安装路径存在
    __en_error_php_path_self,   // readlink获取失败
    __en_error_php_path_bin,    // 上一层目录不是bin
    __en_error_php_path_prefix, // 安装目录获取失败
    __en_error_EN_path          // ENVIRMENT环境目录不存在
} __en_path_status_type;

typedef enum __en_php_define_type {
    EN_DEF_PEAR_INSTALLDIR = 1,
    EN_DEF_PHP_INCLUDE_PATH,
    EN_DEF_PHP_EXTENSION_DIR,
    EN_DEF_PHP_PREFIX,
    EN_DEF_PHP_BINDIR,
    EN_DEF_PHP_SBINDIR,
    EN_DEF_PHP_MANDIR,
    EN_DEF_PHP_LIBDIR,
    EN_DEF_PHP_DATADIR,
    EN_DEF_PHP_SYSCONFDIR,
    EN_DEF_PHP_LOCALSTATEDIR,
    EN_DEF_PHP_CONFIG_FILE_PATH,
    EN_DEF_PHP_CONFIG_FILE_SCAN_DIR,
} __en_php_define;

size_t __get_register_length(const char * const str);

// 动态获取PHP安装路径
int __get_dynamic_php_prefix_path();
// 获取动态路径
char *__get_dynamic_php_mosaics_path(const char *prefix, const char *suffix, const __en_php_define type);
// 错误信息提示
void __en_error_msg(const __en_path_status_type);

#endif // DYNAMIC_PATH_H

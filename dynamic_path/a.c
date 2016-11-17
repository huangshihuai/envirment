#include <stdio.h>
#include "dynamic_path.h"
#include "en_build_defs.h"

// 这块测试代码
void test1(void);
void test2(void);

int main() {
    test1();
}

void test1(void) {
    printf("%s\n", PEAR_INSTALLDIR);
//    printf("%s\n", PHP_INCLUDE_PATH);
//    printf("%s\n", PHP_EXTENSION_DIR);
    printf("%s\n", PHP_PREFIX);
    printf("%s\n", PHP_BINDIR);
    printf("%s\n", PHP_SBINDIR);
    printf("%s\n", PHP_MANDIR);
    printf("%s\n", PHP_LIBDIR);
    printf("%s\n", PHP_DATADIR);
    printf("%s\n", PHP_SYSCONFDIR);
    printf("%s\n", PHP_LOCALSTATEDIR);
    printf("%s\n", PHP_CONFIG_FILE_PATH);
    printf("%s\n", PHP_CONFIG_FILE_SCAN_DIR);
}

void test2(void)
{
//    char *buf = NULL;
//    // PEAR_INSTALLDIR
//    buf = __get_dynamic_php_mosaics_path("", "/lib/php");
//    printf("%s\n", buf);
//
//    // PEAR_INCLUDE_PATH
//    buf = __get_dynamic_php_mosaics_path(".:", "/lib/php");
//    printf("%s\n", buf);
//
//    // PHP_EXTENSIONDIR
//    buf = __get_dynamic_php_mosaics_path("", "/etc");
//    printf("%s\n", buf);
//
//    // PHP_PREFIX
//    buf = __get_dynamic_php_mosaics_path("", "");
//    printf("%s\n", buf);
//
//    // PHP_BINDIR
//    buf = __get_dynamic_php_mosaics_path("", "/bin");
//    printf("%s\n", buf);
//
//    // sbin
//    buf = __get_dynamic_php_mosaics_path("", "/sbin");
//    printf("%s\n", buf);
//
//    // PHP_MANDIR
//    buf = __get_dynamic_php_mosaics_path("", "/php/man");
//    printf("%s\n", buf);
//
//    // PHP_LIBDIR
//    buf = __get_dynamic_php_mosaics_path("", "/lib/php");
//    printf("%s\n", buf);
//
//    // PHP_DATADIR
//    buf = __get_dynamic_php_mosaics_path("", "/share/php");
//    printf("%s\n", buf);
//
//    // PHP_SYSCONFDIR
//    buf = __get_dynamic_php_mosaics_path("", "/etc");
//    printf("%s\n", buf);
//
//    // PHP_LOCALSTATEDIR
//    buf = __get_dynamic_php_mosaics_path("", "/var");
//    printf("%s\n", buf);
//
//    // PHP_CONFIG_FILE_PATH
//    buf = __get_dynamic_php_mosaics_path("", "/etc");
//    printf("%s\n", buf);
//
//    // PHP_CONFIG_FILE_SCAN_PATH
//    buf = __get_dynamic_php_mosaics_path("", "/etc/ext");
//    printf("%s\n", buf);
}

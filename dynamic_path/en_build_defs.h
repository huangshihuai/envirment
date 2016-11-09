#ifndef EN_BUILD_DEFS__
#define EN_BUILD_DEFS__
#include "dynamic_path.h"

#undef PEAR_INSTALLDIR
#define PEAR_INSTALLDIR         __get_dynamic_php_mosaics_path("", "/lib/php", EN_DEF_PEAR_INSTALLDIR)

//#undef PHP_INCLUDE_PATH
//#define PHP_INCLUDE_PATH	__get_dynamic_php_mosaics_path(".:", "/lib/php", EN_DEF_PHP_INCLUDE_PATH)

//#undef PHP_EXTENSION_DIR
//#define PHP_EXTENSION_DIR       __get_dynamic_php_mosaics_path("", "/etc", EN_DEF_PHP_EXTENSION_DIR)

#undef PHP_PREFIX
#define PHP_PREFIX              __get_dynamic_php_mosaics_path("", "", EN_DEF_PHP_PREFIX)

#undef PHP_BINDIR
#define PHP_BINDIR              __get_dynamic_php_mosaics_path("", "/bin", EN_DEF_PHP_BINDIR)

#undef PHP_SBINDIR
#define PHP_SBINDIR             __get_dynamic_php_mosaics_path("", "/sbin", EN_DEF_PHP_SBINDIR)

#undef PHP_MANDIR
#define PHP_MANDIR              __get_dynamic_php_mosaics_path("", "/php/man", EN_DEF_PHP_MANDIR)

#undef PHP_LIBDIR
#define PHP_LIBDIR              __get_dynamic_php_mosaics_path("", "/lib/php", EN_DEF_PHP_LIBDIR)

#undef PHP_DATADIR
#define PHP_DATADIR             __get_dynamic_php_mosaics_path("", "/share/php", EN_DEF_PHP_DATADIR)

#undef PHP_SYSCONFDIR
#define PHP_SYSCONFDIR          __get_dynamic_php_mosaics_path("", "/etc", EN_DEF_PHP_SYSCONFDIR)

#undef PHP_LOCALSTATEDIR
#define PHP_LOCALSTATEDIR       __get_dynamic_php_mosaics_path("", "/var", EN_DEF_PHP_LOCALSTATEDIR)

#undef PHP_CONFIG_FILE_PATH
#define PHP_CONFIG_FILE_PATH    __get_dynamic_php_mosaics_path("", "/etc", EN_DEF_PHP_CONFIG_FILE_PATH)

#undef PHP_CONFIG_FILE_SCAN_DIR
#define PHP_CONFIG_FILE_SCAN_DIR    __get_dynamic_php_mosaics_path("", "/etc/ext", EN_DEF_PHP_CONFIG_FILE_SCAN_DIR)

#endif // EN_BUILD_DEFS__

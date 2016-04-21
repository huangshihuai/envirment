/*                                                                -*- C -*-
   +----------------------------------------------------------------------+
   | PHP Version 5                                                        |
   +----------------------------------------------------------------------+
   | Copyright (c) 1997-2007 The PHP Group                                |
   +----------------------------------------------------------------------+
   | This source file is subject to version 3.01 of the PHP license,      |
   | that is bundled with this package in the file LICENSE, and is        |
   | available through the world-wide-web at the following url:           |
   | http://www.php.net/license/3_01.txt                                  |
   | If you did not receive a copy of the PHP license and are unable to   |
   | obtain it through the world-wide-web, please send a note to          |
   | license@php.net so we can mail you a copy immediately.               |
   +----------------------------------------------------------------------+
   | Author: Stig Sæther Bakken <ssb@php.net>                             |
   +----------------------------------------------------------------------+
*/

/* $Id$ */

#define CONFIGURE_COMMAND " '../configure'  '--prefix=/root/envirment-t/php' '--with-config-file-path=/root/envirment-t/php/etc' '--with-config-file-scan-dir=/root/envirment-t/php/etc/ext' '--enable-bcmath' '--enable-fpm' '--enable-gd-native-ttf' '--enable-mbstring' '--enable-shmop' '--enable-soap' '--enable-sockets' '--enable-sysvsem' '--enable-pcntl' '--enable-zip' '--enable-gd-jis-conv' '--enable-ftp' '--enable-calendar' '--enable-exif' '--enable-fd-setsize=4096' '--enable-opcache' '--with-gd' '--with-pear' '--with-xmlrpc' '--with-openssl=/root/envirment-t/depend/openssl' '--with-zlib=/root/envirment-t/depend/zlib' '--with-curl=/root/envirment-t/depend/curl' '--with-mcrypt=/root/envirment-t/depend/mcrypt' '--with-t1lib=/root/envirment-t/depend/t1lib' '--with-freetype-dir=/root/envirment-t/depend/freetype' '--with-jpeg-dir=/root/envirment-t/depend/jpeg' '--with-png-dir=/root/envirment-t/depend/png' '--with-libxml-dir=/root/envirment-t/depend/xml' '--with-mysql' '--with-pdo-mysql' '--with-xpm-dir' '--with-gettext' '--with-iconv-dir' '--with-fpm-user=www' '--with-fpm-group=www' '--enable-debug'"
#define PHP_ADA_INCLUDE		""
#define PHP_ADA_LFLAGS		""
#define PHP_ADA_LIBS		""
#define PHP_APACHE_INCLUDE	""
#define PHP_APACHE_TARGET	""
#define PHP_FHTTPD_INCLUDE      ""
#define PHP_FHTTPD_LIB          ""
#define PHP_FHTTPD_TARGET       ""
#define PHP_CFLAGS		"$(CFLAGS_CLEAN) -prefer-non-pic -static"
#define PHP_DBASE_LIB		""
#define PHP_BUILD_DEBUG		" -Wall"
#define PHP_GDBM_INCLUDE	""
#define PHP_IBASE_INCLUDE	""
#define PHP_IBASE_LFLAGS	""
#define PHP_IBASE_LIBS		""
#define PHP_IFX_INCLUDE		""
#define PHP_IFX_LFLAGS		""
#define PHP_IFX_LIBS		""
#define PHP_INSTALL_IT		""
#define PHP_IODBC_INCLUDE	""
#define PHP_IODBC_LFLAGS	""
#define PHP_IODBC_LIBS		""
#define PHP_MSQL_INCLUDE	""
#define PHP_MSQL_LFLAGS		""
#define PHP_MSQL_LIBS		""
#define PHP_MYSQL_INCLUDE	""
#define PHP_MYSQL_LIBS		""
#define PHP_MYSQL_TYPE		""
#define PHP_ODBC_INCLUDE	""
#define PHP_ODBC_LFLAGS		""
#define PHP_ODBC_LIBS		""
#define PHP_ODBC_TYPE		""
#define PHP_OCI8_SHARED_LIBADD 	""
#define PHP_OCI8_DIR			""
#define PHP_OCI8_ORACLE_VERSION		""
#define PHP_ORACLE_SHARED_LIBADD 	"@ORACLE_SHARED_LIBADD@"
#define PHP_ORACLE_DIR				"@ORACLE_DIR@"
#define PHP_ORACLE_VERSION			"@ORACLE_VERSION@"
#define PHP_PGSQL_INCLUDE	""
#define PHP_PGSQL_LFLAGS	""
#define PHP_PGSQL_LIBS		""
#define PHP_PROG_SENDMAIL	"/usr/sbin/sendmail"
#define PHP_SOLID_INCLUDE	""
#define PHP_SOLID_LIBS		""
#define PHP_EMPRESS_INCLUDE	""
#define PHP_EMPRESS_LIBS	""
#define PHP_SYBASE_INCLUDE	""
#define PHP_SYBASE_LFLAGS	""
#define PHP_SYBASE_LIBS		""
#define PHP_DBM_TYPE		""
#define PHP_DBM_LIB		""
#define PHP_LDAP_LFLAGS		""
#define PHP_LDAP_INCLUDE	""
#define PHP_LDAP_LIBS		""
#define PHP_BIRDSTEP_INCLUDE     ""
#define PHP_BIRDSTEP_LIBS        ""
#define PEAR_INSTALLDIR         "/root/envirment-t/php/lib/php"
#define PHP_INCLUDE_PATH	".:/root/envirment-t/php/lib/php"
#define PHP_EXTENSION_DIR       "/root/envirment-t/php/lib/php/extensions/debug-non-zts-20131226"
#define PHP_PREFIX              "/root/envirment-t/php"
#define PHP_BINDIR              "/root/envirment-t/php/bin"
#define PHP_SBINDIR             "/root/envirment-t/php/sbin"
#define PHP_MANDIR              "/root/envirment-t/php/php/man"
#define PHP_LIBDIR              "/root/envirment-t/php/lib/php"
#define PHP_DATADIR             "/root/envirment-t/php/share/php"
#define PHP_SYSCONFDIR          "/root/envirment-t/php/etc"
#define PHP_LOCALSTATEDIR       "/root/envirment-t/php/var"
#define PHP_CONFIG_FILE_PATH    "/root/envirment-t/php/etc"
#define PHP_CONFIG_FILE_SCAN_DIR    "/root/envirment-t/php/etc/ext"
#define PHP_SHLIB_SUFFIX        "so"

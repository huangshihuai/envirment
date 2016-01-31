#define NGX_CONFIGURE " --prefix=/home/hsh/envirment/webserver/nginx --sbin-path=/home/hsh/envirment/webserver/nginx/sbin/nginx --conf-path=/home/hsh/envirment/webserver/nginx/conf/nginx.conf --error-log-path=/home/hsh/envirment/log/error.log --http-log-path=/home/hsh/envirment/log/access.log --pid-path=/home/hsh/envirment/var/nginx.pid --lock-path=/home/hsh/envirment/var/nginx.lock --http-client-body-temp-path=/home/hsh/envirment/webserver/nginx/cache/client_body --http-fastcgi-temp-path=/home/hsh/envirment/webserver/nginx/cache/proxy --http-uwsgi-temp-path=/home/hsh/envirment/webserver/nginx/cache/uwsgi --http-scgi-temp-path=/home/hsh/envirment/webserver/nginx/cache/scgi --http-fastcgi-temp-path=/home/hsh/envirment/webserver/nginx/cache/fastcgi --user=hsh --group=hsh --with-ipv6 --without-select_module --without-poll_module --with-file-aio --with-http_realip_module --with-http_ssl_module --with-http_gzip_static_module --with-http_stub_status_module --without-http_ssi_module --without-http_userid_module --without-http_geo_module --without-http_empty_gif_module --without-http_map_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-md5-asm --with-md5=/home/hsh/envirment/source/depend/openssl --with-sha1-asm --with-sha1=/home/hsh/envirment/source/depend/openssl --with-openssl=/home/hsh/envirment/source/depend/openssl --with-pcre=/home/hsh/envirment/source/depend/pcre --with-pcre-jit --with-zlib=/home/hsh/envirment/source/depend/zlib --without-http_autoindex_module --without-http_auth_basic_module --without-http_browser_module --without-http_limit_conn_module --without-http_limit_req_module --without-http_memcached_module --without-http_referer_module --without-http_proxy_module --without-http_scgi_module"

#ifndef NGX_COMPILER
#define NGX_COMPILER  "gcc 4.9.2 (Ubuntu 4.9.2-10ubuntu13) "
#endif


#ifndef NGX_HAVE_GCC_ATOMIC
#define NGX_HAVE_GCC_ATOMIC  1
#endif


#ifndef NGX_HAVE_C99_VARIADIC_MACROS
#define NGX_HAVE_C99_VARIADIC_MACROS  1
#endif


#ifndef NGX_HAVE_GCC_VARIADIC_MACROS
#define NGX_HAVE_GCC_VARIADIC_MACROS  1
#endif


#ifndef NGX_HAVE_EPOLL
#define NGX_HAVE_EPOLL  1
#endif


#ifndef NGX_HAVE_CLEAR_EVENT
#define NGX_HAVE_CLEAR_EVENT  1
#endif


#ifndef NGX_HAVE_EPOLLRDHUP
#define NGX_HAVE_EPOLLRDHUP  1
#endif


#ifndef NGX_HAVE_O_PATH
#define NGX_HAVE_O_PATH  1
#endif


#ifndef NGX_HAVE_SENDFILE
#define NGX_HAVE_SENDFILE  1
#endif


#ifndef NGX_HAVE_SENDFILE64
#define NGX_HAVE_SENDFILE64  1
#endif


#ifndef NGX_HAVE_PR_SET_DUMPABLE
#define NGX_HAVE_PR_SET_DUMPABLE  1
#endif


#ifndef NGX_HAVE_SCHED_SETAFFINITY
#define NGX_HAVE_SCHED_SETAFFINITY  1
#endif


#ifndef NGX_HAVE_GNU_CRYPT_R
#define NGX_HAVE_GNU_CRYPT_R  1
#endif


#ifndef NGX_HAVE_NONALIGNED
#define NGX_HAVE_NONALIGNED  1
#endif


#ifndef NGX_CPU_CACHE_LINE
#define NGX_CPU_CACHE_LINE  64
#endif


#define NGX_KQUEUE_UDATA_T  (void *)


#ifndef NGX_HAVE_POSIX_FADVISE
#define NGX_HAVE_POSIX_FADVISE  1
#endif


#ifndef NGX_HAVE_O_DIRECT
#define NGX_HAVE_O_DIRECT  1
#endif


#ifndef NGX_HAVE_ALIGNED_DIRECTIO
#define NGX_HAVE_ALIGNED_DIRECTIO  1
#endif


#ifndef NGX_HAVE_STATFS
#define NGX_HAVE_STATFS  1
#endif


#ifndef NGX_HAVE_STATVFS
#define NGX_HAVE_STATVFS  1
#endif


#ifndef NGX_HAVE_SCHED_YIELD
#define NGX_HAVE_SCHED_YIELD  1
#endif


#ifndef NGX_HAVE_DEFERRED_ACCEPT
#define NGX_HAVE_DEFERRED_ACCEPT  1
#endif


#ifndef NGX_HAVE_KEEPALIVE_TUNABLE
#define NGX_HAVE_KEEPALIVE_TUNABLE  1
#endif


#ifndef NGX_HAVE_TCP_FASTOPEN
#define NGX_HAVE_TCP_FASTOPEN  1
#endif


#ifndef NGX_HAVE_TCP_INFO
#define NGX_HAVE_TCP_INFO  1
#endif


#ifndef NGX_HAVE_ACCEPT4
#define NGX_HAVE_ACCEPT4  1
#endif


#ifndef NGX_HAVE_FILE_AIO
#define NGX_HAVE_FILE_AIO  1
#endif


#ifndef NGX_HAVE_EVENTFD
#define NGX_HAVE_EVENTFD  1
#endif


#ifndef NGX_HAVE_SYS_EVENTFD_H
#define NGX_HAVE_SYS_EVENTFD_H  1
#endif


#ifndef NGX_HAVE_UNIX_DOMAIN
#define NGX_HAVE_UNIX_DOMAIN  1
#endif


#ifndef NGX_PTR_SIZE
#define NGX_PTR_SIZE  8
#endif


#ifndef NGX_SIG_ATOMIC_T_SIZE
#define NGX_SIG_ATOMIC_T_SIZE  4
#endif


#ifndef NGX_HAVE_LITTLE_ENDIAN
#define NGX_HAVE_LITTLE_ENDIAN  1
#endif


#ifndef NGX_MAX_SIZE_T_VALUE
#define NGX_MAX_SIZE_T_VALUE  9223372036854775807LL
#endif


#ifndef NGX_SIZE_T_LEN
#define NGX_SIZE_T_LEN  (sizeof("-9223372036854775808") - 1)
#endif


#ifndef NGX_MAX_OFF_T_VALUE
#define NGX_MAX_OFF_T_VALUE  9223372036854775807LL
#endif


#ifndef NGX_OFF_T_LEN
#define NGX_OFF_T_LEN  (sizeof("-9223372036854775808") - 1)
#endif


#ifndef NGX_TIME_T_SIZE
#define NGX_TIME_T_SIZE  8
#endif


#ifndef NGX_TIME_T_LEN
#define NGX_TIME_T_LEN  (sizeof("-9223372036854775808") - 1)
#endif


#ifndef NGX_MAX_TIME_T_VALUE
#define NGX_MAX_TIME_T_VALUE  9223372036854775807LL
#endif


#ifndef NGX_HAVE_INET6
#define NGX_HAVE_INET6  1
#endif


#ifndef NGX_HAVE_PREAD
#define NGX_HAVE_PREAD  1
#endif


#ifndef NGX_HAVE_PWRITE
#define NGX_HAVE_PWRITE  1
#endif


#ifndef NGX_SYS_NERR
#define NGX_SYS_NERR  135
#endif


#ifndef NGX_HAVE_LOCALTIME_R
#define NGX_HAVE_LOCALTIME_R  1
#endif


#ifndef NGX_HAVE_POSIX_MEMALIGN
#define NGX_HAVE_POSIX_MEMALIGN  1
#endif


#ifndef NGX_HAVE_MEMALIGN
#define NGX_HAVE_MEMALIGN  1
#endif


#ifndef NGX_HAVE_MAP_ANON
#define NGX_HAVE_MAP_ANON  1
#endif


#ifndef NGX_HAVE_MAP_DEVZERO
#define NGX_HAVE_MAP_DEVZERO  1
#endif


#ifndef NGX_HAVE_SYSVSHM
#define NGX_HAVE_SYSVSHM  1
#endif


#ifndef NGX_HAVE_POSIX_SEM
#define NGX_HAVE_POSIX_SEM  1
#endif


#ifndef NGX_HAVE_MSGHDR_MSG_CONTROL
#define NGX_HAVE_MSGHDR_MSG_CONTROL  1
#endif


#ifndef NGX_HAVE_FIONBIO
#define NGX_HAVE_FIONBIO  1
#endif


#ifndef NGX_HAVE_GMTOFF
#define NGX_HAVE_GMTOFF  1
#endif


#ifndef NGX_HAVE_D_TYPE
#define NGX_HAVE_D_TYPE  1
#endif


#ifndef NGX_HAVE_SC_NPROCESSORS_ONLN
#define NGX_HAVE_SC_NPROCESSORS_ONLN  1
#endif


#ifndef NGX_HAVE_OPENAT
#define NGX_HAVE_OPENAT  1
#endif


#ifndef NGX_HAVE_GETADDRINFO
#define NGX_HAVE_GETADDRINFO  1
#endif


#ifndef NGX_HTTP_CACHE
#define NGX_HTTP_CACHE  1
#endif


#ifndef NGX_HTTP_GZIP
#define NGX_HTTP_GZIP  1
#endif


#ifndef NGX_HTTP_GZIP
#define NGX_HTTP_GZIP  1
#endif


#ifndef NGX_HTTP_REALIP
#define NGX_HTTP_REALIP  1
#endif


#ifndef NGX_HTTP_X_FORWARDED_FOR
#define NGX_HTTP_X_FORWARDED_FOR  1
#endif


#ifndef NGX_HTTP_SSL
#define NGX_HTTP_SSL  1
#endif


#ifndef NGX_STAT_STUB
#define NGX_STAT_STUB  1
#endif


#ifndef NGX_PCRE
#define NGX_PCRE  1
#endif


#ifndef NGX_HAVE_PCRE_JIT
#define NGX_HAVE_PCRE_JIT  1
#endif


#ifndef NGX_OPENSSL
#define NGX_OPENSSL  1
#endif


#ifndef NGX_SSL
#define NGX_SSL  1
#endif


#ifndef NGX_HAVE_OPENSSL_MD5_H
#define NGX_HAVE_OPENSSL_MD5_H  1
#endif


#ifndef NGX_OPENSSL_MD5
#define NGX_OPENSSL_MD5  1
#endif


#ifndef NGX_HAVE_MD5
#define NGX_HAVE_MD5  1
#endif


#ifndef NGX_ZLIB
#define NGX_ZLIB  1
#endif


#ifndef NGX_PREFIX
#define NGX_PREFIX  "/home/hsh/envirment/webserver/nginx/"
#endif


#ifndef NGX_CONF_PREFIX
#define NGX_CONF_PREFIX  "/home/hsh/envirment/webserver/nginx/conf/"
#endif


#ifndef NGX_SBIN_PATH
#define NGX_SBIN_PATH  "/home/hsh/envirment/webserver/nginx/sbin/nginx"
#endif


#ifndef NGX_CONF_PATH
#define NGX_CONF_PATH  "/home/hsh/envirment/webserver/nginx/conf/nginx.conf"
#endif


#ifndef NGX_PID_PATH
#define NGX_PID_PATH  "/home/hsh/envirment/var/nginx.pid"
#endif


#ifndef NGX_LOCK_PATH
#define NGX_LOCK_PATH  "/home/hsh/envirment/var/nginx.lock"
#endif


#ifndef NGX_ERROR_LOG_PATH
#define NGX_ERROR_LOG_PATH  "/home/hsh/envirment/log/error.log"
#endif


#ifndef NGX_HTTP_LOG_PATH
#define NGX_HTTP_LOG_PATH  "/home/hsh/envirment/log/access.log"
#endif


#ifndef NGX_HTTP_CLIENT_TEMP_PATH
#define NGX_HTTP_CLIENT_TEMP_PATH  "/home/hsh/envirment/webserver/nginx/cache/client_body"
#endif


#ifndef NGX_HTTP_PROXY_TEMP_PATH
#define NGX_HTTP_PROXY_TEMP_PATH  "proxy_temp"
#endif


#ifndef NGX_HTTP_FASTCGI_TEMP_PATH
#define NGX_HTTP_FASTCGI_TEMP_PATH  "/home/hsh/envirment/webserver/nginx/cache/fastcgi"
#endif


#ifndef NGX_HTTP_UWSGI_TEMP_PATH
#define NGX_HTTP_UWSGI_TEMP_PATH  "/home/hsh/envirment/webserver/nginx/cache/uwsgi"
#endif


#ifndef NGX_HTTP_SCGI_TEMP_PATH
#define NGX_HTTP_SCGI_TEMP_PATH  "/home/hsh/envirment/webserver/nginx/cache/scgi"
#endif


#ifndef NGX_SUPPRESS_WARN
#define NGX_SUPPRESS_WARN  1
#endif


#ifndef NGX_SMP
#define NGX_SMP  1
#endif


#ifndef NGX_USER
#define NGX_USER  "hsh"
#endif


#ifndef NGX_GROUP
#define NGX_GROUP  "hsh"
#endif


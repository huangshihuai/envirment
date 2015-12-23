nginx的依赖库
openssl 是 link -> openssl-xx.xx.xx
这是openssl库,根据不同版本创建新的link

cd nginx-source/auto/lib/openssl/conf

CORE_INCS="$CORE_INCS $OPENSSL/.openssl/include"  
CORE_DEPS="$CORE_DEPS $OPENSSL/.openssl/include/openssl/ssl.h"  
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libssl.a"  
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libcrypto.a"
修改成:
CORE_INCS="$CORE_INCS $OPENSSL/include"
CORE_DEPS="$CORE_DEPS $OPENSSL/include/openssl/ssl.h"  
CORE_LIBS="$CORE_LIBS $OPENSSL/libssl.a"  
CORE_LIBS="$CORE_LIBS $OPENSSL/libcrypto.a"  
CORE_LIBS="$CORE_LIBS $NGX_LIBDL"

#include "dynamic_path.h"
#include <stdlib.h>
#include <stdio.h>
#include <libgen.h>
#include <limits.h>
#include <unistd.h>

char __php_prefix[PATH_MAX] = {0};

int __get_dynamic_php_prefix_path() {
    if (__php_prefix[0]) {
        return 0;
    }
    char buffer[PATH_MAX] = {0};
    if (readlink("/proc/self/exe", buffer, PATH_MAX) < 0) {
        return -1;
    }
    // 获取php上一层目录:bin
    if (dirname(buffer) != buffer) {
        return -1;
    }
    printf("%s\n", buffer);
    // 获取到PHP目录
    if (dirname(buffer) != buffer) {
        return -1;
    }
    snprintf(__php_prefix, PATH_MAX, "%s", buffer);
    return 0;
}

char *__get_dynamic_path_mosaics(const char *prefix, const char *special) {
}

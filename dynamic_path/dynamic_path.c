#include "dynamic_path.h"
#include <stdlib.h>
#include <stdio.h>
#include <libgen.h>
#include <limits.h>
#include <unistd.h>

char __php_prefix[PATH_MAX] = {0};

char *__get_dynamic_php_prefix_path() {
    size_t len = 0;
    if ((len = readlink("/proc/self/exe", __php_prefix, PATH_MAX)) < 0) {
    }
}

char *__get_dynamic_path_mosaics(const char *prefix, const char *special) {
}

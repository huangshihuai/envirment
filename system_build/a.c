#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <malloc.h>

#define __PATH_MAX 35
char *__php_prefix = NULL;

char* __get_prefix_path();
int main(void)
{
    char *tp = NULL;
    if ((tp = __get_prefix_path()) != NULL){
        free(tp);
    }
}

char* __get_prefix_path() {
    char *buf = (char *)malloc(sizeof(char) * __PATH_MAX + 1);
    char *more_buf = NULL;
    size_t len = 0;
    int buf_len = __PATH_MAX;
    while(1) {
        if ((len = readlink("/proc/self/exe", buf, buf_len + 1)) < 0) {
            free(buf);
            buf = NULL;
            break;
        }
        if (len <= buf_len) {
            buf[len] = '\0';
            break;
        }
        buf_len *= 2;
        if ((more_buf = realloc(buf, sizeof(char) * (buf_len + 1))) == NULL) {
            free(buf);
            buf = NULL;
            break;
        }
        buf = more_buf;
        more_buf = NULL;
    }
    return buf;
}

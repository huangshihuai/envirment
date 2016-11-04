#ifndef DYNAMIC_PATH_H
#define DYNAMIC_PATH_H

// 动态获取PHP安装路径
char *__get_dynamic_php_prefix_path();
// 获取动态路径
char *__get_dynamic_path_mosaics(const char *prefix, const char *special);

#endif // DYNAMIC_PATH_H

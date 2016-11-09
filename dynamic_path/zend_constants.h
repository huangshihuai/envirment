/********
 *
 * 这块需要移植到zend/zend_constants.h
 * 在REGISTER_MAIN_STRINGL_CONSTANT宏后面
 */
#include "dynamic_path.h"

#undef REGISTER_MAIN_STRINGL_CONSTANT
#define REGISTER_MAIN_STRINGL_CONSTANT(name, str, len, flags) {\
    size_t str_len = __get_register_length((str));\
    zend_register_stringl_constant((name), sizeof(name) - 1, (str), str_len, (flags), 0); \
}

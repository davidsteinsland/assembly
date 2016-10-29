#include "util.h"
#include "syscalls.h"
#include "string.h"

/*
  row +----+----+----+----+----+----+----+----+
   0  |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |
      +----+----+----+----+----+----+----+----+
   1  |  9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 |
      +----+----+----+----+----+----+----+----+
              .....
 */
#define PRINT_TEMPLATE                                                  \
char* table_delim = "    +----+----+----+----+----+----+----+----+\n";  \
uint8_t i, j;                                                           \
for (i = 0; i < 8; ++i) {                                               \
  put_strz(table_delim);                                                \
  if (i < 10) {                                                         \
    put_char(' ');                                                      \
  }                                                                     \
  put_int(i);                                                           \
  put_char(' ');                                                        \
  put_char(' ');                                                        \
  for (j = 0; j < 8; ++j) {                                             \
    put_char('|');                                                      \
    put_char(' ');                                                      \
    if (in[i * 8 + j] < 10) {                                           \
      put_char(' ');                                                    \
    }                                                                   \
    put_int(in[i * 8 + j]);                                             \
    put_char(' ');                                                      \
  }                                                                     \
  put_char('|');                                                        \
  put_char('\n');                                                       \
}                                                                       \
put_strz(table_delim);

/*
  +----+----+----+----+----+----+----+----+
  |  1 |  2 |  3 |  4 |  5 |  6 |  7 |  8 |
  +----+----+----+----+----+----+----+----+
 */
#define PRINT_ROW_TEMPLATE                                              \
char* table_delim = "    +----+----+----+----+----+----+----+----+\n";  \
uint8_t j;                                                              \
put_strz(table_delim);                                                  \
put_strz("    ");                                                       \
for (j = 0; j < 8; ++j) {                                               \
  put_char('|');                                                        \
  put_char(' ');                                                        \
  if (in[j] < 10) {                                                     \
    put_char(' ');                                                      \
  }                                                                     \
  put_int(in[j]);                                                       \
  put_char(' ');                                                        \
}                                                                       \
put_char('|');                                                          \
put_char('\n');                                                         \
put_strz(table_delim);

void print_8x8_int16(uint16_t in[8 * 8])
{
  PRINT_TEMPLATE
}

void print_8x8_int32(uint32_t in[8 * 8])
{
  PRINT_TEMPLATE
}

void print_8_int16(uint16_t in[8])
{
  PRINT_ROW_TEMPLATE
}

void print_8_int32(uint32_t in[8])
{
  PRINT_ROW_TEMPLATE
}

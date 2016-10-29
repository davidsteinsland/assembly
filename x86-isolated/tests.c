#include "tests.h"

int _test_transpose_int16(uint16_t* P, uint16_t* expected, uint16_t* result)
{
  transpose_8x8_int16(P, result);

  uint8_t i;

  for (i = 0; i < 64; ++i) {
    if (result[i] != expected[i]) {
      put_strz("Expected ");
      put_int(expected[i]);
      put_strz(" at ");
      put_int(i);
      put_strz(", but got ");
      put_int(result[i]);
      put_char('\n');

      return 1;
    }
  }

  return 0;
}

int _test_transpose_int32(uint32_t* P, uint32_t* expected, uint32_t* result)
{
  transpose_8x8_int32(P, result);

  uint8_t i;

  for (i = 0; i < 64; ++i) {
    if (result[i] != expected[i]) {
      put_strz("Expected ");
      put_int(expected[i]);
      put_strz(" at ");
      put_int(i);
      put_strz(", but got ");
      put_int(result[i]);
      put_char('\n');

      return 1;
    }
  }

  return 0;
}

void test_transpose_int16()
{
  put_strz("TEST SSE TRANSPOSE 8X8 INT16\n");
  put_strz("=============================\n");

  uint16_t P[64];
  uint16_t expected[64];

  unsigned char i;
  for (i = 0; i < 64; ++i) {
    P[i] = i + 1;
  }

  unsigned char j;
  for (i = 0; i < 8; ++i) {
    for (j = 0; j < 8; ++j) {
      expected[i * 8 + j] = P[j * 8 + i];
    }
  }

  uint16_t result[64];
  transpose_8x8_int16(P, result);

  if (!_test_transpose_int16(P, expected, result)) {
    put_strz("Test OK!\n");
    put_strz("=============================\n\n");
    return;
  }

  put_strz("Input array\n");
  print_8x8_int16(P);
  put_char('\n');

  put_strz("Expected array\n");
  print_8x8_int16(expected);
  put_char('\n');

  put_strz("Result array\n");
  print_8x8_int16(result);
  put_char('\n');

  put_strz("SSE test failed!\n");

  put_strz("=============================\n\n");
}

void test_transpose_int32()
{
  put_strz("TEST AVX2 TRANSPOSE 8X8 INT32\n");
  put_strz("=============================\n");

  uint32_t P[64];
  uint32_t expected[64];

  unsigned char i;
  for (i = 0; i < 64; ++i) {
    P[i] = i + 1;
  }

  unsigned char j;
  for (i = 0; i < 8; ++i) {
    for (j = 0; j < 8; ++j) {
      expected[i * 8 + j] = P[j * 8 + i];
    }
  }

  uint32_t result[64];

  if (!_test_transpose_int32(P, expected, result)) {
    put_strz("Test OK!\n");
    put_strz("=============================\n\n");
    return;
  }

  put_strz("Input array\n");
  print_8x8_int32(P);
  put_char('\n');

  put_strz("Expected array\n");
  print_8x8_int32(expected);
  put_char('\n');

  put_strz("Result array\n");
  print_8x8_int32(result);
  put_char('\n');

  put_strz("AVX2 test failed!\n");

  put_strz("=============================\n\n");
}

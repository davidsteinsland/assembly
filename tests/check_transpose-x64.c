#include <stdlib.h>
#include <check.h>

extern void transpose_8x8(uint32_t* a, uint32_t* b);
extern void transpose_8x8_one_more(uint32_t* a, uint32_t* b);

START_TEST(test_8x8_arrays_are_equal)
{
  unsigned int P[64];
  unsigned char i;
  for (i = 0; i < 64; ++i) {
    P[i] = i + 1;
  }

  unsigned int expected[64];

  transpose_8x8(P, expected);

  unsigned int actual[64];
  transpose_8x8_one_more(P, actual);

  for (i = 0; i < 64; ++i) {
    fail_unless(expected[i] == actual[i], "Arrays should be equal");
  }
}
END_TEST

Suite *transpose_suite(void) {
  Suite *suite;
  TCase *test_case;

  suite = suite_create("array transpose");
  test_case = tcase_create("8x8 array");
  tcase_add_test(test_case, test_8x8_arrays_are_equal);
  suite_add_tcase(suite, test_case);

  return suite;
}

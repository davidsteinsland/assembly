#include <stdlib.h>
#include <check.h>

extern int* binary_search(unsigned int size, int* list, int search);

START_TEST(test_empty_array)
{
  int P[] = {};
  fail_unless(binary_search(0, P, 0) == NULL, "Search on empty array should return NULL");
}
END_TEST

START_TEST(test_array_size_1)
{
  int P[] = {5};
  fail_unless(binary_search(1, P, 5) == P, "Index should be 0");
}
END_TEST

START_TEST(test_array_size_1_not_found)
{
  int P[] = {5};
  fail_unless(binary_search(1, P, 4) == NULL, "Index should be NULL");
}
END_TEST

START_TEST(test_array_size_2)
{
  int P[] = {5, 10};
  fail_unless(binary_search(2, P, 5) == &P[0], "Index should be 0");
  fail_unless(binary_search(2, P, 10) == &P[1], "Index should be 1");
}
END_TEST

START_TEST(test_array_size_3)
{
  int P[] = {5, 10, 100};
  fail_unless(binary_search(3, P, 5) == &P[0], "Index should be 0");
  fail_unless(binary_search(3, P, 10) == &P[1], "Index should be 1");
  fail_unless(binary_search(3, P, 100) == &P[2], "Index should be 2");
}
END_TEST

START_TEST(test_array_size_4)
{
  int P[] = {5, 10, 100, 101};
  fail_unless(binary_search(4, P, 5) == &P[0], "Index should be 0");
  fail_unless(binary_search(4, P, 10) == &P[1], "Index should be 1");
  fail_unless(binary_search(4, P, 100) == &P[2], "Index should be 2");
  fail_unless(binary_search(4, P, 101) == &P[3], "Index should be 3");
}
END_TEST

START_TEST(test_signed_numbers)
{
  int P[] = {-50, -10, 0, 100, 101};
  fail_unless(binary_search(5, P, -50) == &P[0], "Index should be 0");
  fail_unless(binary_search(5, P, -10) == &P[1], "Index should be 1");
  fail_unless(binary_search(5, P, 0) == &P[2], "Index should be 2");
  fail_unless(binary_search(5, P, 100) == &P[3], "Index should be 3");
  fail_unless(binary_search(5, P, 101) == &P[4], "Index should be 4");
}
END_TEST

START_TEST(test_signed_numbers2)
{
  int P[] = {-2456, -1024, -267, -155, -50, -10, 0, 1, 5, 6, 19, 32, 53, 54, 100, 101};

  fail_unless(binary_search(16, P, -2456) == &P[0], "Index should be 0");
  fail_unless(binary_search(16, P, -10) == &P[5], "Index should be 5");

  fail_unless(binary_search(16, P, 7) == NULL, "Index should be NULL");
  fail_unless(binary_search(16, P, 1000) == NULL, "Index should be NULL");
  fail_unless(binary_search(16, P, -2555) == NULL, "Index should be NULL");
}
END_TEST

Suite *bs_suite(void) {
  Suite *suite;
  TCase *test_case;

  suite = suite_create("binary search");
  test_case = tcase_create("binary search");
  tcase_add_test(test_case, test_empty_array);
  tcase_add_test(test_case, test_array_size_1);
  tcase_add_test(test_case, test_array_size_1_not_found);
  tcase_add_test(test_case, test_array_size_2);
  tcase_add_test(test_case, test_array_size_3);
  tcase_add_test(test_case, test_array_size_4);
  tcase_add_test(test_case, test_signed_numbers);
  tcase_add_test(test_case, test_signed_numbers2);
  suite_add_tcase(suite, test_case);

  return suite;
}

#include <stdlib.h>
#include <check.h>

Suite *bs_suite(void);
Suite *transpose_suite(void);

int main(void) {
  int number_failed;
  SRunner *runner;

  runner = srunner_create(bs_suite());
  srunner_add_suite (runner, transpose_suite());

  srunner_run_all(runner, CK_NORMAL);
  number_failed = srunner_ntests_failed(runner);
  srunner_free(runner);

  return number_failed == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}

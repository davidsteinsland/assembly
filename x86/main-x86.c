#include <stdio.h>

/* prototype for asm function */
extern void put_char(char c);
extern int put_str(char*);
extern int my_strlen(char*);
extern int add_args(int, int);
extern void print_welcome();
extern int add_my_ints(int, int, int, int, int, int, int, int);
extern int my_min(int, int*);
extern int my_max(int, int*);
extern void print_int_array();
extern int num_digits(int);
extern int print_int(int);

int main()
{
  print_welcome();

  int k = put_str("What are you doing mate?\n");
  printf("Wrote %d chars\n", k);

  put_char('H');
  put_char('e');
  put_char('l');
  put_char('l');
  put_char('o');
  put_char('\n');

  printf("Length of string: Hello, World! is %d bytes\n", my_strlen("Hello, World!"));

  printf("15 should be %d\n", add_args(5, 10));

  printf("36 should be %d\n", add_my_ints(1, 2, 3, 4, 5, 6, 7, 8));

  int ints[] = {-5, 98, 4, 72};
  printf("The minima of {-5, 98, 4, 72} is = %d\n", my_min(4, ints));
  printf("The maxima of {-5, 98, 4, 72} is = %d\n", my_max(4, ints));

  print_int_array();
  printf("\n");

  printf("1 is %d digits\n", num_digits(1));
  printf("9 is %d digits\n", num_digits(9));
  printf("10 is %d digits\n", num_digits(10));
  printf("99 is %d digits\n", num_digits(99));
  printf("100 is %d digits\n", num_digits(100));
  printf("999 is %d digits\n", num_digits(999));
  printf("1000 is %d digits\n", num_digits(1000));
  printf("10000 is %d digits\n", num_digits(10000));

  printf("\nThe integer is %d digits long\n", print_int(1024));
  printf("\nThe integer is %d digits long\n", print_int(99));
  printf("\nThe integer is %d digits long\n", print_int(0));

  printf("\n");

  return 0;
}

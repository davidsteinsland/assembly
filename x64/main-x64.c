#include <stdio.h>
#include <inttypes.h>

/* prototype for asm function */
extern void put_char(char c);
extern int put_str(char*);
extern int my_strlen(char*);
extern int add_args(int, int);
extern void print_welcome();
extern int add_my_ints(int, int, int, int, int, int, int, int);
extern int my_min(int, int*);
extern int my_max(int, int*);
extern int* binary_search(unsigned int size, int* list, int search);
extern unsigned int binary_search_unsigned(unsigned int size, unsigned int* list, unsigned int search);
extern int call_me(int, int (*func)(int));

int hello(int a) {
  printf("You are %d years old!\n", a);
  return 100;
}

// a = base pointer
// b = address of array element
#define ADDR_TO_INDEX(a, b) (b == NULL ? -1 : (((unsigned int)b - (unsigned int)a)/sizeof(int)))

uint64_t rdtsc()
{
  uint32_t lo, hi;
  __asm__ __volatile__ ("rdtsc" : "=a" (lo), "=d" (hi));
  return ((uint64_t)hi << 32) | lo;
}

int main()
{
  print_welcome();

  printf("After %d turns\n", call_me(36, &hello));

  int P[] = {-5, 0, 1, 5, 25, 31, 55, 68, 91, 102};
  int K = 10;
  int* Q;

  uint64_t A, B;

  int M;
  for (M = 0; M < K; ++M) {
    A = rdtsc();
    Q = binary_search(K, P, P[M]);
    B = rdtsc();
    printf("%d is at  ... %d (%llu cycles)\n", P[M], ADDR_TO_INDEX(P, Q), B - A);
  }

  A = rdtsc();
  Q = binary_search(K, P, -10);
  B = rdtsc();
  printf("-10 is at  ... %d (%llu cycles)\n", ADDR_TO_INDEX(P, Q), B - A);
  A = rdtsc();
  Q = binary_search(K, P, 100);
  B = rdtsc();
  printf("100 is at  ... %d (%llu cycles)\n", ADDR_TO_INDEX(P, Q), B - A);
  A = rdtsc();
  Q = binary_search(K, P, 200);
  B = rdtsc();
  printf("200 is at  ... %d (%llu cycles)\n", ADDR_TO_INDEX(P, Q), B - A);

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

  printf("\n");

  return 0;
}

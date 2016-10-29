#include <stdio.h>

extern void cpuid(int*, int*, int*);

int main() {
  int a, b, c;

  a = 0; b = 0; c = 0;
  cpuid(&a, &b, &c);

  printf("%d\n%d\n%d\n", a, b, c);
  printf("%s\n", (char*)&a);
  printf("%s\n", (char*)&b);
  printf("%s\n", (char*)&c);

  return 0;
}

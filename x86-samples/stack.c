
void foo() {
  /* allocate 10 bytes */
  unsigned int P[] = {5, 8, 1, 4, 10, 15, 2, 7, 0, 3};

  /* do something with P, so that it wont be optimized out */
  bar(P);
}

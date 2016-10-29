int foo(int p, int* q) {
  int min = 999999;
  int i;
  for (i = 0; i < p; ++i) {
    if (q[i] < min) {
      min = q[i];
    }
  }

  return min;
}

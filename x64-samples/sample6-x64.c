int call_me(int a, int (*func)(int)) {
  return func(a);
}

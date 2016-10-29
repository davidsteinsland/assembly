
int bar(char c) {
  char* p = 0;
  p = &c;
}

void foo() {
  bar('c');
}

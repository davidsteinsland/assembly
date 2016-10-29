
static int baz = 5;
int bazbaz = 10;

int bar() {
    static int a = 0;

    return a++;
}

int barbar() {
    return 2;
}

static int foo() {
    return 1;
}

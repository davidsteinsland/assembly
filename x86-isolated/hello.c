#include <stdio.h>

#include "syscalls.h"
#include "inttypes.h"
#include "string.h"
#include "tests.h"

int main(int argc, char** argv)
{
  /*test_transpose_int16();
  test_transpose_int32();*/

  char* s = "Hello, World!\n";
  put_strz(s);

  put_strz("My PID is: ");
  int pid = getpid();
  put_int(pid);
  put_char('\n');

  put_strz("Argument count: ");
  put_int(argc);
  put_char('\n');

  put_strz("Executable: ");
  put_strz(argv[0]);
  put_char('\n');

  uint8_t i;
  for (i = 1; i < argc; ++i) {
    put_strz("- ");
    put_strz(argv[i]);
    put_char('\n');
  }

  put_strz("Goodbye");
  put_char('\n');

  return 0;
}

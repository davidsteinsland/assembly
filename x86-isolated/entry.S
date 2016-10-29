#
# This is the canonical entry point, usually the first thing in the text
# segment.  The SVR4/i386 ABI (pages 3-31, 3-32) says that when the entry
# point runs, most registers' values are unspecified, except for:

# %esp   The stack contains the arguments and environment:
# 0(%esp)     argc
# 4(%esp)     argv[0]
# ...
# (4*argc)(%esp)    NULL
# (4*(argc+1))(%esp)  envp[0]
# ...
#       NULL
.globl start

start:
  # Clear the frame pointer.  The ABI suggests this be done, to mark
  # the outermost frame obviously.
  xorl %ebp, %ebp

  # Extract the arguments as encoded on the stack and set up
  # the arguments for `main': argc, argv.

  # Pop the argument count.
  popl %esi
  # argv starts just at the current stack top.
  movl %esp, %ecx

  # Before pushing the arguments align the stack to a 16-byte
  # (SSE needs 16-byte alignment) boundary to avoid penalties from
  # misaligned accesses.
  andl $0xfffffff0, %esp

  # clear %eax, in case of "void main(...)"
  xorl %eax, %eax

  # push argc on stack
  pushl %ecx
  pushl %esi

  # int main(int argc, char** argv)
  call _main

  addl $8, %esp

  # exit with whatever %eax contains ...
  push %eax
  movl $1, %eax
  subl $4, %esp
  int $0x80

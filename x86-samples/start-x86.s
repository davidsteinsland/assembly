#
# gcc -nostdlib start-x86.s -o hello hello.c
#
# as start-x86.s -o start-x86.o
# ld start-x86.o -o start-x86
#
# This is the canonical entry point, usually the first thing in the text
# segment.  The SVR4/i386 ABI (pages 3-31, 3-32) says that when the entry
# point runs, most registers' values are unspecified, except for:

# %edx   Contains a function pointer to be registered with `atexit'.
# This is how the dynamic linker arranges to have DT_FINI
# functions called for shared libraries that have been loaded
# before this code runs.

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
  # the arguments for `main': argc, argv.  envp will be determined
  # later in __libc_start_main.
  popl %esi # Pop the argument count.
  movl %esp, %ecx #argv starts just at the current stack top.

  # Before pushing the arguments align the stack to a 16-byte
  # (SSE needs 16-byte alignment) boundary to avoid penalties from
  # misaligned accesses.  Thanks to Edward Seidl <seidl@janed.com>
  # for pointing this out.  */
  andl $0xfffffff0, %esp

  xorl %eax, %eax
  pushl %esi
  pushl %ecx
  # int main(int argc, char** argv)
  call _main

  # exit with whatever the %eax contains
  xorl %ebx, %ebx
  int $0x80

.text

.globl _strlen
.globl _put_int

# GCC requires that some registers not change across a function call.
# They are:
# - %ebx
# - %esi
# - %edi
# - %ebp

# int strlen(char* s)
_strlen:
  pushl %ebp
  movl %esp, %ebp

  movl 8(%ebp), %ecx

strlen_start:
  # check if we have reached NULL byte
  cmpb $0, (%ecx)
  je strlen_end
  addl $1, %ecx
  jmp strlen_start

strlen_end:
  movl %ecx, %eax
  subl 8(%ebp), %eax

  movl %ebp, %esp
  popl %ebp
  ret

# int put_int(int)
_put_int:
  pushl %ebp
  movl %esp, %ebp

  movl 8(%ebp), %eax

  subl $4, %esp
  movl $10, -4(%ebp)

  # i = 0
  xorl %ecx, %ecx

# while eax > 0
print_int_loop:
  xorl %edx, %edx
  # # eax = eax / 10
  divl -4(%ebp)
  # push eax % 10
  pushl %edx
  incl %ecx

  cmpl $0, %eax
  jg print_int_loop

  # the number of pops are equal
  # to the value of %ecx
  movl %ecx, %eax

print_int_loop_2:
  # move current int to %ebx
  popl %edx

  # convert int to ascii and print
  addl $0x30, %edx

  # preserve eax
  pushl %eax
  # preserve ecx
  pushl %ecx

  pushl %edx
  call _put_char
  addl $4, %esp

  popl %ecx
  popl %eax

  decl %ecx

  cmpl $0, %ecx
  jg print_int_loop_2

print_int_end:
  movl %ebp, %esp
  popl %ebp
  ret

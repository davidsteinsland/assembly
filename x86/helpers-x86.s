.text

# Give these functions external linkage
.globl _put_char
.globl _put_str
.globl _my_strlen
.globl _add_args
.globl _print_welcome
.globl _add_my_ints
.globl _my_min
.globl _my_max
.globl _print_int_array
.globl _num_digits
.globl _print_int

#
# GCC requires that some registers not change across a function call.
# They are:
# - %ebx
# - %esi
# - %edi
# - %ebp
#
# The return address is located at 16(%ebp).
.macro cdecl_start
  pushl %ebp
  pushl %esi
  pushl %edi
  pushl %ebx
  movl %esp, %ebp
.endm

.macro cdecl_end
  movl %ebp, %esp
  popl %ebx
  popl %edi
  popl %esi
  popl %ebp
.endm

# int my_max(int, int*);
# We are assuming array size of at least 1!!!
_my_max:
  pushl %ebp
  movl %esp, %ebp

  movl $1, %edi
  movl 12(%ebp), %ecx
  movl (%ecx), %eax

find_max:
  cmpl 8(%ebp), %edi
  # if %edi >= 8(%ebp) ==> if i >= array_size, jump away
  jge find_min_end
  cmpl (%ecx, %edi, 4), %eax
  # if  %eax >= (%ecx, %edi, 4) >= ==> if max >= p[i], jump away
  jge find_max_next

  # we have found a new maxima
  movl (%ecx, %edi, 4), %eax

find_max_next:
  incl %edi
  jmp find_max

find_max_end:
  movl %ebp, %esp
  popl %ebp
  ret

# int my_min(int, int*);
# We are assuming array size of at least 1!!!
_my_min:
  pushl %ebp
  movl %esp, %ebp

  # reset counter
  movl $1, %edi

  # load int pointer into %ecx
  movl 12(%ebp), %ecx

  # set first element as minima
  movl (%ecx), %eax

find_min:
  cmpl 8(%ebp), %edi
  # if %edi >= 8(%ebp) ==> if i >= array_size, jump away
  jge find_min_end
  cmpl %eax, (%ecx, %edi, 4)
  # if (%ecx, %edi, 4) >= %eax ==> if p[i] >= min, jump away
  jge find_min_next

  # we have found a new minima
  movl (%ecx, %edi, 4), %eax

find_min_next:
  incl %edi
  jmp find_min

find_min_end:
  movl %ebp, %esp
  popl %ebp
  ret

_add_my_ints:
  pushl %ebp
  movl %esp, %ebp
  xorl %eax, %eax

  addl 8(%ebp), %eax
  addl 12(%ebp), %eax
  addl 16(%ebp), %eax
  addl 20(%ebp), %eax
  addl 24(%ebp), %eax
  addl 28(%ebp), %eax
  addl 32(%ebp), %eax
  addl 36(%ebp), %eax

  movl %ebp, %esp
  popl %ebp
  ret

_add_args:
  cdecl_start

  movl 20(%ebp), %eax
  addl 24(%ebp), %eax

  cdecl_end
  ret

_my_strlen:
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

# void put_char(char c)
_put_char:
  pushl %ebp
  movl %esp, %ebp

  # the argument c is given to us on stack at pos
  # %ebp + 8.
  # we then simply move the _address_ of that location into %ecx,
  # similar to:
  # int* p = &c
  leal 8(%ebp), %ecx

  pushl $1
  pushl %ecx
  pushl $1
  movl $4, %eax
  subl $4, %esp
  int $0x80

  # clear %eax, return void
  xorl %eax, %eax

  movl %ebp, %esp
  popl %ebp
  ret

# int put_str(char* str)
_put_str:
  pushl %ebp
  movl %esp, %ebp

  # loop over c until NULL byte is met
  # for each char in c, call _put_char

  # move char pointer into %ecx
  movl 8(%ebp), %ecx
  pushl %ecx
  call _my_strlen
  # restore %ecx, because my_strlen is using the same register
  popl %ecx

  # length of string, as returned by my_strlen
  pushl %eax
  # push current address of char pointer
  pushl %ecx
  # file descriptor, stdout
  pushl $1
  # syscall number 4
  movl $4, %eax
  # align stack to 16 bytes
  subl $4, %esp
  int $0x80
  addl $12, %esp

  popl %eax

  movl %ebp, %esp
  popl %ebp
  ret

_print_welcome:
  pushl %ebp
  movl %esp, %ebp

  # pushes the return address (%eip) onto stack
  call print_welcome_str
print_welcome_str:
  # pops return address/%eip into %eax
  popl  %eax

# Now that we have the return address inside %eax,
# we calculate the difference between welcome_msg and print_welcome_str.
# This gives us the offset at which the string is stored, relative to %eax.
#
# offset = welcome_msg - print_welcome_str
# str = %eax + offset
#
# Note, on 64-bit systems, we could instead do this:
# lea welcome_msg(%rip), %rdi
#
# ... as the first six integer or pointer arguments are passed in registers RDI, RSI, RDX, RCX, R8, and R9.
  leal  (welcome_msg - print_welcome_str)(%eax), %eax
  pushl %eax
  call _put_str

  movl %ebp, %esp
  popl %ebp
  ret

_num_digits:
  pushl %ebp
  movl %esp, %ebp

  movl $1, %eax
  movl $10, %ecx

num_digits_loop:
  # while a > %ecx
  cmpl %ecx, 8(%ebp)
  jl num_digits_end
  incl %eax
  # k = k * 10
  # k = (k << 1) + (k << 3)
  movl %ecx, %ebx
  shll $1, %ecx
  shll $3, %ebx
  addl %ebx, %ecx
  jmp num_digits_loop

num_digits_end:
  movl %ebp, %esp
  popl %ebp
  ret

# int mod(int a, int b)
_mod:
  pushl %ebp
  movl %esp, %ebp

  # Unsigned divide EDX:EAX by r/m32,
  # with result stored in EAX = Quotient, EDX = Remainder.
  #
  # +--------------+--------+---------+---------+
  # | divisor size | 1 byte | 2 bytes | 4 bytes |
  # +--------------+--------+---------+---------+
  # | dividend     |   AX   |  DX:AX  | EDX:EAX |
  # +--------------+--------+---------+---------+
  # | remainder    |   AH   |   DX    |   EDX   |
  # +--------------+--------+---------+---------+
  # | quotient     |   AL   |   AX    |   EAX   |
  # +--------------+--------+---------+---------+
  #
  # The colon (:) means concatenation.
  # With divisor size 4, this means that EDX are the bits 32-63
  # and EAX are bits 0-31 of the input number
  # (with lower bit numbers being less significant, in this example).
  #
  # As you typically have 32-bit input values for division,
  # you often need to use CDQ to sign-extend EAX
  # into EDX just before the division.
  #
  # If quotient does not fit into quotient register,
  # arithmetic overflow interrupt occurs.
  #
  # All flags are in undefined state after the operation.
  movl 8(%ebp), %eax
  xorl %edx, %edx
  divl 12(%ebp)
  movl %edx, %eax

  movl %ebp, %esp
  popl %ebp
  ret

# int print_int(int)
_print_int:
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
  popl %ebx

  # convert int to ascii and print
  addl $0x30, %ebx

  # preserve eax
  pushl %eax
  # preserve ecx
  pushl %ecx

  pushl %ebx
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

_print_int_array:
  pushl %ebp
  movl %esp, %ebp

  call move_int_array
move_int_array:
  # move EIP into %eax
  popl %eax

  # move address of int_array to %eax
  leal (int_array - move_int_array)(%eax), %eax

  # i = 0
  xorl %ecx, %ecx
loop_int_array:
  # loop until i = 10
  cmpl $10, %ecx
  je loop_int_end

  pushl %eax
  pushl %ecx

  # move current int to stack
  pushl (%eax, %ecx, 4)
  call _print_int
  addl $4, %esp

  # print comma
  pushl $0x2C
  call _put_char
  addl $4, %esp

  popl %ecx
  popl %eax

  incl %ecx
  jmp loop_int_array

loop_int_end:
  movl %ebp, %esp
  popl %ebp
  ret

welcome_msg:
  .asciz "Welcome to IA-32/x86 Assembly.\n\n"

int_array:
  .long 5                       ## 0x5
  .long 8                       ## 0x8
  .long 1                       ## 0x1
  .long 14                       ## 0x4
  .long 1                      ## 0xa
  .long 9                      ## 0xf
  .long 2                       ## 0x2
  .long 709                       ## 0x7
  .long 0                       ## 0x0
  .long 3                       ## 0x3

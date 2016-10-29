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
.globl _binary_search
.globl _binary_search_unsigned
.globl _call_me

# The first six integer or pointer arguments are passed in registers RDI, RSI, RDX, RCX, R8, and R9.
# Additional arguments are passed on the stack and the return value is stored in RAX
# If the callee wishes to use registers RBP, RBX, and R12–R15,
# it must restore their original values before returning control to the caller.
# All others must be saved by the caller if it wishes to preserve their values

# extern int call_me(int, int (*func)(int));
_call_me:
  # return value is placed in %rax, which
  # will be filled by call_me
  #
  # call_me should receive one argument,
  # and that's given by %rdi
  jmpq *%rsi

# int32_t* binary_search(uint32_t size, int32_t* list, int32_t search)
_binary_search:
  pushq %rbp
  movq %rsp, %rbp

  # set return value to 0
  movl $0, %eax

  #  iff size = 0, return
  testl %edi, %edi
  jz bs_end

  # p = 0
  xorl %ecx, %ecx
  # q = size - 1
  decl %edi

  jmp bs_loop

bs_search_left:
  # iff list[m] > search
  # q = m - 1
  leal -1(%ebx), %edi
  jmp bs_pre_loop

bs_search_right:
  # list[m] < search
  # p = m + 1
  leal 1(%ebx), %ecx

bs_pre_loop:
# iff p <= q, go to loop
  cmpl %ecx, %edi
  jl bs_end

bs_loop:
  # m = q + p
  # %rdi = q
  # %rcx = p
  # %ebx = m
  leal (%rdi, %rcx), %ebx
  # m = m >> 1
  shrl %ebx

  # compare search and list[m]
  # %rdx/%edx: search value
  # %esi: list pointer
  # %ebx * 4: index
  cmpl %edx, (%rsi, %rbx, 4)
# iff list[m] < search
  jl bs_search_right
  jg bs_search_left

  leaq (%rsi, %rbx, 4), %rax

bs_end:
  #movq %rbp, %rsp
  #popq %rbp
  leave

  ret

# uint32_t binary_search(uint32_t size, uint32_t* list, uint32_t search)
_binary_search_unsigned:
  pushq %rbp
  movq %rsp, %rbp

  # set return value to -1
  movq $-1, %rax

#  iff size <= 0, return
  testl %edi, %edi
  jle binary_search_end

  # p = 0
  movq $0, %rcx
  # q = size - 1
  subq $1, %rdi

while_p_is_less_than_or_equal_to_q:
  # m = p + (q - p)/2 === (q + p)/2
  leaq (%rdi, %rcx), %rbx
  sarq %rbx

  # compare search and list[m]
  cmpl %edx, (%rsi, %rbx, 4)
# iff list[m] <= search
  jle possible_match_less_than

  # list[m] > search

  # q = m - 1
  leaq -1(%rdi), %rdi
  jmp test_if_p_is_less_than_or_equal_to_q

possible_match_less_than:
# iff list[m] >= search
  jge found_match

  # list[m] < search
  leaq 1(%rcx), %rcx

test_if_p_is_less_than_or_equal_to_q:
# iff p <= q, go to loop
  cmpq %rcx, %rdi
  jge while_p_is_less_than_or_equal_to_q
# iff p > q, return
  jmp binary_search_end

found_match:
  movq %rbx, %rax

binary_search_end:
  #movq %rbp, %rsp
  #popq %rbp
  leave

  ret

# int my_max(int, int*);
# We are assuming array size of at least 1!!!
_my_max:
  pushq %rbp
  movq %rsp, %rbp

  # set counter to 1
  movq $1, %rbx
  # set first element as minima
  movq (%rsi), %rax

find_max:
  cmpq %rdi, %rbx
  jge find_max_end
  cmpl (%rsi, %rbx, 4), %eax
  jge find_max_next
  movq (%rsi, %rbx, 4), %rax

find_max_next:
  incq %rbx
  jmp find_max

find_max_end:
  movq %rbp, %rsp
  popq %rbp

  ret

# int my_min(int, int*);
# We are assuming array size of at least 1!!!
_my_min:
  pushq %rbp
  movq %rsp, %rbp

  # set counter to 1
  movq $1, %rbx
  # set first element as minima
  movq (%rsi), %rax

find_min:
  cmpq %rdi, %rbx
  jge find_min_end
  # we are comparing int32, not int64
  cmpl %eax, (%rsi, %rbx, 4)
# iff (%esi, %rbx, 4) >= min, jump away
  jge find_min_next
  # we have found a new minima
  movq (%rsi, %rbx, 4), %rax

find_min_next:
  incq %rbx
  jmp find_min

find_min_end:
  movq %rbp, %rsp
  popq %rbp

  ret

_add_my_ints:
  # This function will take 8 arguments, meaning that two arguments
  # are placed on the stack
  pushq %rbp
  movq %rsp, %rbp
  xorq %rax, %rax

  addq %rdi, %rax
  addq %rsi, %rax
  addq %rdx, %rax
  addq %rcx, %rax
  addq %r8, %rax
  addq %r9, %rax

  # pushed %rbp is stored in (%rbp)
  # return address is 8(%rbp)
  # and so on. because we're in 64 bits,
  # each integer is 8 bytes.
  addq 16(%rbp), %rax
  addq 24(%rbp), %rax

  movq %rbp, %rsp
  popq %rbp

  ret

_my_strlen:
  pushq %rbp
  movq %rsp, %rbp

  xorq %rax, %rax

my_strlen_start:
  cmpb $0, (%rdi)
  je my_strlen_end
  addq $1, %rdi
  incq %rax
  jmp my_strlen_start

my_strlen_end:
  movq %rbp, %rsp
  popq %rbp

  ret

_add_args:
  pushq %rbp
  movq %rsp, %rbp

  movq %rdi, %rax
  addq %rsi, %rax

  movq %rbp, %rsp
  popq %rbp

  ret

# void put_char(char c)
_put_char:
  pushq %rbp
  movq %rsp, %rbp

  # first argument is placed in %rdi, but we are only interested
  # in the lower 8 bits of that register, namely %dil.
  # so we place the character on stack, so we can get the address for it
  movb %dil, -5(%rbp)
  # also note that System V AMD64 ABI mandates that we have a 128 bytes red zone below stack.
  # this means that we don't need to allocate space for local vars, as long
  # as we dont use more than 128 bytes.

  # load effective address of <%rbp - 5> into %rsi
  leaq -5(%rbp), %rsi

  # file descriptor, stdout
  movq $1, %rdi
  # length of char
  movq $1, %rdx
  # syscall number 4
  movq $0x2000004, %rax

  syscall

  # clear %rax, return void
  xorq %rax, %rax

  movq %rbp, %rsp
  popq %rbp

  ret

# int put_str(char* str)
_put_str:
  pushq %rbp
  movq %rsp, %rbp

  # loop over c until NULL byte is met
  # for each char in c, call _put_char
  pushq %rdi
  call _my_strlen
  popq %rdi

  # save string length
  pushq %rax

  # string length is stored in %rax,
  # char pointer is still in %rdi

  # push current address of char pointer
  movq %rdi, %rsi
  # file descriptor, stdout
  movq $1, %rdi
  # length of string, as returned by my_strlen
  movq %rax, %rdx
  # syscall number 4
  movq $0x2000004, %rax

  # Syscall, as defined in:
  # https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
  #
  # +----------------+------------------------------------------------------------------+
  # | Syscall number |                             Prototype                            |
  # +----------------+------------------------------------------------------------------+
  # |       4        | user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); |
  # +----------------+------------------------------------------------------------------+
  syscall

  popq %rax

  movq %rbp, %rsp
  popq %rbp

  ret

_print_welcome:
  pushq %rbp
  movq %rsp, %rbp

  leaq welcome_msg(%rip), %rdi
  call _put_str

  movq %rbp, %rsp
  popq %rbp

  ret

welcome_msg:
  .asciz "Welcome to x86-64 Assembly.\n\n"

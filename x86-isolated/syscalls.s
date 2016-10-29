.text

# Give these functions external linkage
.globl _put_char
.globl _put_str
.globl _put_strz
.globl _getpid
.globl _exit

# void exit(int)
_exit:
  pushl %ebp
  movl %esp, %ebp

  # Syscall, as defined in:
  # https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
  #
  # +----------------+----------------------+
  # | Syscall number |      Prototype       |
  # +----------------+----------------------+
  # |       1        | void exit(int rval); |
  # +----------------+----------------------+

  movl $1, %eax
  pushl 8(%ebp)
  subl $4, %esp
  int $0x80

  # iff interrupt returned ...
  hlt

# int getpid(void)
_getpid:
  pushl %ebp
  movl %esp, %ebp

  # Syscall, as defined in:
  # https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
  #
  # +----------------+-------------------+
  # | Syscall number |     Prototype     |
  # +----------------+-------------------+
  # |      20        | int getpid(void); |
  # +----------------+-------------------+
  movl $20, %eax
  int $0x80

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
_put_strz:
  pushl %ebp
  movl %esp, %ebp

  pushl 8(%ebp)
  call _strlen
  addl $4, %esp

  pushl 8(%ebp)
  pushl %eax
  call _put_str

  movl %ebp, %esp
  popl %ebp

  ret

# int put_str(int len, char* str)
_put_str:
  pushl %ebp
  movl %esp, %ebp

  # Syscall, as defined in:
  # https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
  #
  # +----------------+------------------------------------------------------------------+
  # | Syscall number |                             Prototype                            |
  # +----------------+------------------------------------------------------------------+
  # |       4        | user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); |
  # +----------------+------------------------------------------------------------------+

  # length of string, as returned by my_strlen
  pushl 8(%ebp)
  # push current address of char pointer
  pushl 12(%ebp)
  # file descriptor, stdout
  pushl $1
  # syscall number 4
  movl $4, %eax
  # align stack to 16 bytes
  subl $4, %esp
  int $0x80
  addl $12, %esp

  movl 8(%ebp), %eax

  movl %ebp, %esp
  popl %ebp
  ret

.text

# Give these functions external linkage
.globl _cpuid

# void my_max(int* a, int* b, int* c);
_cpuid:
  pushl %ebp
  movl %esp, %ebp

  # a = 8(%ebp)
  # b = 12(%ebp)
  # c = 16(%ebp)

  xorl %eax, %eax

  # uses EAX, EBX, ECX, and EDX
  cpuid

  # free are ESI, EDI
  movl 8(%ebp), %esi
  movl %ebx, (%esi)

  movl 12(%ebp), %esi
  movl %ecx, (%esi)

  movl 16(%ebp), %esi
  movl %edx, (%esi)

  # move int ptr "a" to

  movl %ebp, %esp
  popl %ebp

  ret

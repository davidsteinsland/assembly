# -----------------------------------------------------------------------------
# A 64-bit Linux application that writes the first 90 Fibonacci numbers.  It
# needs to be linked with a C library.
#
# Assemble and Link:
#     gcc fib.s
# OSX:
# as fib.s -g -c -Wall -o fib.o
# ld -lc -macosx_version_min 10.11 fib.o -o fib
# -----------------------------------------------------------------------------

.text
.globl _main

_main:
        pushq %rbp
        pushq %rbx
        pushq %rax
        movq %rsp, %rbp

        subq $16, %rsp

        mov     $10, %ecx               # ecx will countdown to 0
        xor     %rax, %rax              # rax will hold the current number
        xor     %rbx, %rbx              # rbx will hold the next number
        inc     %rbx                    # rbx is originally 1
print:
        # We need to call printf, but we are using eax, ebx, and ecx.  printf
        # may destroy eax and ecx so we will save these before the call and
        # restore them afterwards.

        push    %rax                    # caller-save register
        push    %rcx                    # caller-save register

        leaq    format(%rip), %rdi           # set 1st parameter (format)
        mov     %rax, %rsi              # set 2nd parameter (current_number)
        xor     %rax, %rax              # because printf is varargs

        # Stack is already aligned because we pushed three 8 byte registers
        call    _printf

        pop     %rcx                    # restore caller-save register
        pop     %rax                    # restore caller-save register

        mov     %rax, %rdx              # save the current number
        mov     %rbx, %rax              # next number is now current
        add     %rdx, %rbx              # get the new next number
        dec     %ecx                    # count down
        jnz     print                   # if not done counting, do some more

        movq %rbp, %rsp
        popq %rax
        popq %rbx
        popq %rbp

        xorq %rax, %rax

        ret
format:
        .asciz  "%20ld\n"

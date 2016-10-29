	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_foo
	.align	4, 0x90
_foo:                                   ## @foo
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
Ltmp3:
	.cfi_offset %rbx, -56
Ltmp4:
	.cfi_offset %r12, -48
Ltmp5:
	.cfi_offset %r13, -40
Ltmp6:
	.cfi_offset %r14, -32
Ltmp7:
	.cfi_offset %r15, -24
	movl	120(%rbp), %eax
	movl	112(%rbp), %r10d
	movl	104(%rbp), %r11d
	movl	96(%rbp), %ebx
	movl	88(%rbp), %r14d
	movl	80(%rbp), %r15d
	movl	72(%rbp), %r12d
	movl	64(%rbp), %r13d
	movl	%eax, -128(%rbp)        ## 4-byte Spill
	movl	56(%rbp), %eax
	movl	%eax, -132(%rbp)        ## 4-byte Spill
	movl	48(%rbp), %eax
	movl	%eax, -136(%rbp)        ## 4-byte Spill
	movl	40(%rbp), %eax
	movl	%eax, -140(%rbp)        ## 4-byte Spill
	movl	32(%rbp), %eax
	movl	%eax, -144(%rbp)        ## 4-byte Spill
	movl	24(%rbp), %eax
	movl	%eax, -148(%rbp)        ## 4-byte Spill
	movl	16(%rbp), %eax
	movl	%edi, -44(%rbp)
	movl	%esi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movl	%ecx, -56(%rbp)
	movl	%r8d, -60(%rbp)
	movl	%r9d, -64(%rbp)
	movl	%eax, -68(%rbp)
	movl	-148(%rbp), %eax        ## 4-byte Reload
	movl	%eax, -72(%rbp)
	movl	-144(%rbp), %ecx        ## 4-byte Reload
	movl	%ecx, -76(%rbp)
	movl	-140(%rbp), %edx        ## 4-byte Reload
	movl	%edx, -80(%rbp)
	movl	-136(%rbp), %esi        ## 4-byte Reload
	movl	%esi, -84(%rbp)
	movl	-132(%rbp), %edi        ## 4-byte Reload
	movl	%edi, -88(%rbp)
	movl	%r13d, -92(%rbp)
	movl	%r12d, -96(%rbp)
	movl	%r15d, -100(%rbp)
	movl	%r14d, -104(%rbp)
	movl	%ebx, -108(%rbp)
	movl	%r11d, -112(%rbp)
	movl	%r10d, -116(%rbp)
	movl	-128(%rbp), %r8d        ## 4-byte Reload
	movl	%r8d, -120(%rbp)
	movl	-44(%rbp), %r9d
	addl	-48(%rbp), %r9d
	addl	-52(%rbp), %r9d
	addl	-56(%rbp), %r9d
	addl	-60(%rbp), %r9d
	addl	-64(%rbp), %r9d
	addl	-68(%rbp), %r9d
	addl	-72(%rbp), %r9d
	addl	-76(%rbp), %r9d
	addl	-80(%rbp), %r9d
	addl	-84(%rbp), %r9d
	addl	-88(%rbp), %r9d
	addl	-92(%rbp), %r9d
	addl	-96(%rbp), %r9d
	addl	-100(%rbp), %r9d
	addl	-104(%rbp), %r9d
	addl	-108(%rbp), %r9d
	addl	-112(%rbp), %r9d
	addl	-116(%rbp), %r9d
	addl	-120(%rbp), %r9d
	movl	%r9d, -124(%rbp)
	movl	-124(%rbp), %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp8:
	.cfi_def_cfa_offset 16
Ltmp9:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp10:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
Ltmp11:
	.cfi_offset %rbx, -56
Ltmp12:
	.cfi_offset %r12, -48
Ltmp13:
	.cfi_offset %r13, -40
Ltmp14:
	.cfi_offset %r14, -32
Ltmp15:
	.cfi_offset %r15, -24
	movl	$1, %edi
	movl	$2, %esi
	movl	$3, %edx
	movl	$4, %ecx
	movl	$5, %r8d
	movl	$6, %r9d
	movl	$7, %eax
	movl	$8, %r10d
	movl	$9, %r11d
	movl	$10, %ebx
	movl	$11, %r14d
	movl	$12, %r15d
	movl	$13, %r12d
	movl	$14, %r13d
	movl	%eax, -48(%rbp)         ## 4-byte Spill
	movl	$15, %eax
	movl	%eax, -52(%rbp)         ## 4-byte Spill
	movl	$16, %eax
	movl	%eax, -56(%rbp)         ## 4-byte Spill
	movl	$17, %eax
	movl	%eax, -60(%rbp)         ## 4-byte Spill
	movl	$18, %eax
	movl	%eax, -64(%rbp)         ## 4-byte Spill
	movl	$19, %eax
	movl	%eax, -68(%rbp)         ## 4-byte Spill
	movl	$20, %eax
	movl	$0, -44(%rbp)
	movl	$7, (%rsp)
	movl	$8, 8(%rsp)
	movl	$9, 16(%rsp)
	movl	$10, 24(%rsp)
	movl	$11, 32(%rsp)
	movl	$12, 40(%rsp)
	movl	$13, 48(%rsp)
	movl	$14, 56(%rsp)
	movl	$15, 64(%rsp)
	movl	$16, 72(%rsp)
	movl	$17, 80(%rsp)
	movl	$18, 88(%rsp)
	movl	$19, 96(%rsp)
	movl	$20, 104(%rsp)
	movl	%r13d, -72(%rbp)        ## 4-byte Spill
	movl	%r12d, -76(%rbp)        ## 4-byte Spill
	movl	%r15d, -80(%rbp)        ## 4-byte Spill
	movl	%r14d, -84(%rbp)        ## 4-byte Spill
	movl	%ebx, -88(%rbp)         ## 4-byte Spill
	movl	%r11d, -92(%rbp)        ## 4-byte Spill
	movl	%eax, -96(%rbp)         ## 4-byte Spill
	movl	%r10d, -100(%rbp)       ## 4-byte Spill
	callq	_foo
	xorl	%ecx, %ecx
	movl	%eax, -104(%rbp)        ## 4-byte Spill
	movl	%ecx, %eax
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
	.cfi_endproc


.subsections_via_symbols

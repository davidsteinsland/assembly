	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_binary_search
	.align	4, 0x90
_binary_search:                         ## @binary_search
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
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	$0, -32(%rbp)
	movl	-12(%rbp), %edx
	subl	$1, %edx
	movl	%edx, -36(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-32(%rbp), %eax
	cmpl	-36(%rbp), %eax
	ja	LBB0_9
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-36(%rbp), %eax
	addl	-32(%rbp), %eax
	shrl	$1, %eax
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rdx
	movl	(%rdx,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jle	LBB0_4
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-40(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB0_8
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	movl	-40(%rbp), %eax
	movl	%eax, %ecx
	movq	-24(%rbp), %rdx
	movl	(%rdx,%rcx,4), %eax
	cmpl	-28(%rbp), %eax
	jge	LBB0_6
## BB#5:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-40(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -32(%rbp)
	jmp	LBB0_7
LBB0_6:
	movq	-24(%rbp), %rax
	movl	-40(%rbp), %ecx
	movl	%ecx, %edx
	shlq	$2, %rdx
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	jmp	LBB0_10
LBB0_7:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_8
LBB0_8:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_1
LBB0_9:
	movq	$0, -8(%rbp)
LBB0_10:
	movq	-8(%rbp), %rax
	popq	%rbp
	retq
	.cfi_endproc


.subsections_via_symbols

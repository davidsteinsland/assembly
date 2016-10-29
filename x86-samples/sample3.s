	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_foo
	.align	4, 0x90
_foo:                                   ## @foo
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	movl	%eax, -8(%ebp)
	movl	$999999, -12(%ebp)      ## imm = 0xF423F
	movl	$0, -16(%ebp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-16(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jge	LBB0_6
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %ecx
	movl	(%ecx,%eax,4), %eax
	cmpl	-12(%ebp), %eax
	jge	LBB0_4
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-16(%ebp), %eax
	movl	-8(%ebp), %ecx
	movl	(%ecx,%eax,4), %eax
	movl	%eax, -12(%ebp)
LBB0_4:                                 ##   in Loop: Header=BB0_1 Depth=1
	jmp	LBB0_5
LBB0_5:                                 ##   in Loop: Header=BB0_1 Depth=1
	movl	-16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -16(%ebp)
	jmp	LBB0_1
LBB0_6:
	movl	-12(%ebp), %eax
	addl	$16, %esp
	popl	%ebp
	retl


.subsections_via_symbols

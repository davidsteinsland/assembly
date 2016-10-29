	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_foo
	.align	4, 0x90
_foo:                                   ## @foo
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	xorl	%edx, %edx
	divl	-8(%ebp)
	addl	$8, %esp
	popl	%ebp
	retl

	.globl	_bar
	.align	4, 0x90
_bar:                                   ## @bar
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	%ecx, -4(%ebp)
	movl	%eax, -8(%ebp)
	movl	-4(%ebp), %eax
	xorl	%edx, %edx
	divl	-8(%ebp)
	movl	%edx, %eax
	addl	$8, %esp
	popl	%ebp
	retl


.subsections_via_symbols

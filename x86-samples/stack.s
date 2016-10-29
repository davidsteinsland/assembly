	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.globl	_foo
	.align	4, 0x90
_foo:                                   ## @foo
## BB#0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	subl	$80, %esp
	calll	L0$pb
L0$pb:
	popl	%eax
	leal	-52(%ebp), %ecx
	leal	l_foo.P-L0$pb(%eax), %edx
	movl	$40, %esi
	movl	L___stack_chk_guard$non_lazy_ptr-L0$pb(%eax), %edi
	movl	(%edi), %edi
	movl	%edi, -12(%ebp)
	movl	%ecx, %edi
	movl	%edi, (%esp)
	movl	%edx, 4(%esp)
	movl	$40, 8(%esp)
	movl	%eax, -56(%ebp)         ## 4-byte Spill
	movl	%ecx, -60(%ebp)         ## 4-byte Spill
	movl	%esi, -64(%ebp)         ## 4-byte Spill
	calll	_memcpy
	movl	-60(%ebp), %eax         ## 4-byte Reload
	movl	%eax, (%esp)
	calll	_bar
	movl	-56(%ebp), %ecx         ## 4-byte Reload
	movl	L___stack_chk_guard$non_lazy_ptr-L0$pb(%ecx), %edx
	movl	(%edx), %edx
	cmpl	-12(%ebp), %edx
	movl	%eax, -68(%ebp)         ## 4-byte Spill
	jne	LBB0_2
## BB#1:                                ## %SP_return
	addl	$80, %esp
	popl	%esi
	popl	%edi
	popl	%ebp
	retl
LBB0_2:                                 ## %CallStackCheckFailBlk
	calll	___stack_chk_fail

	.section	__TEXT,__const
	.align	2                       ## @foo.P
l_foo.P:
	.long	5                       ## 0x5
	.long	8                       ## 0x8
	.long	1                       ## 0x1
	.long	4                       ## 0x4
	.long	10                      ## 0xa
	.long	15                      ## 0xf
	.long	2                       ## 0x2
	.long	7                       ## 0x7
	.long	0                       ## 0x0
	.long	3                       ## 0x3


	.section	__IMPORT,__pointers,non_lazy_symbol_pointers
L___stack_chk_guard$non_lazy_ptr:
	.indirect_symbol	___stack_chk_guard
	.long	0

.subsections_via_symbols

	.data
	.align 2
_baz:
	.long	5
	.globl _bazbaz
	.align 2
_bazbaz:
	.long	10
	.text
	.globl _bar
_bar:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	call	___x86.get_pc_thunk.bx
L1$pb:
	leal	_a.1711-L1$pb(%ebx), %eax
	movl	(%eax), %eax
	leal	1(%eax), %ecx
	leal	_a.1711-L1$pb(%ebx), %edx
	movl	%ecx, (%edx)
	popl	%ebx
	popl	%ebp
	ret
	.globl _barbar
_barbar:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$2, %eax
	popl	%ebp
	ret
_foo:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$1, %eax
	popl	%ebp
	ret
	.zerofill __DATA,__bss2,_a.1711,4,2
	.section __TEXT,__textcoal_nt,coalesced,pure_instructions
	.weak_definition	___x86.get_pc_thunk.bx
	.private_extern	___x86.get_pc_thunk.bx
___x86.get_pc_thunk.bx:
	movl	(%esp), %ebx
	ret
	.subsections_via_symbols

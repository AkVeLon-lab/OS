	.file	"fibonachi.cpp"
	.text
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.globl	_Z9fibonaccii
	.type	_Z9fibonaccii, @function
_Z9fibonaccii:
.LFB1999:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	%edi, %ebx
	movslq	%edi, %rax
	cmpl	$1, %edi
	jle	.L1
	leal	-1(%rdi), %edi
	call	_Z9fibonaccii
	movq	%rax, %r14
	leal	-2(%rbx), %edi
	call	_Z9fibonaccii
	addq	%rax, %r14
	movq	%r14, %rax
.L1:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1999:
	.size	_Z9fibonaccii, .-_Z9fibonaccii
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	": "
	.text
	.globl	main
	.type	main, @function
main:
.LFB2000:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$6, %esi
	leaq	_ZSt4cout(%rip), %rdi
	call	_ZNSolsEi@PLT
	movq	%rax, %rdi
	leaq	.LC0(%rip), %rsi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rbx
	movl	$6, %edi
	call	_Z9fibonaccii
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	_ZNSo9_M_insertIyEERSoT_@PLT
	movl	$0, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE2000:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.1 20260209"
	.section	.note.GNU-stack,"",@progbits

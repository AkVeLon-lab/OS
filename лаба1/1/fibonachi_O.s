	.file	"fibonachi.cpp"
	.text
#APP
	.globl _ZSt21ios_base_library_initv  
#NO_APP
	.globl	_Z9fibonaccii     # Имя функции: fibonacci(int)
	.type	_Z9fibonaccii, @function
_Z9fibonaccii:
.LFB1976:
	.cfi_startproc
	pushq	%rbp              # Сохраняем старый указатель фрейма
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp        # Новый фрейм стека
	.cfi_def_cfa_register 6
	pushq	%rbx              # Сохраняем callee-saved регистр (будет исп. как времен. переменная)
	subq	$24, %rsp         # Резервируем 24 байта локальных переменных
	.cfi_offset 3, -24

	movl	%edi, -20(%rbp)   # n (аргумент в edi) сохраняется в стеке по адресу rbp-20

	cmpl	$1, -20(%rbp)     # Сравниваем n с 1
	jg	.L2                   # Если n > 1, переходим к рекурсивному вычислению

	# База рекурсии: return n
	movl	-20(%rbp), %eax   # eax = n
	cltq                      # Расширяем до 64 бит (eax -> rax)
	jmp	.L3                   # Переход к выходу из функции

.L2:
	
	# Вычисление и вызов fibonacci(n-1)
	movl	-20(%rbp), %eax   # eax = n
	subl	$1, %eax          # eax = n - 1
	movl	%eax, %edi        # edi = n-1 (аргумент для вызова)
	call	_Z9fibonaccii     # вызов fibonacci(n-1)
	movq	%rax, %rbx        # <-- ПЕРЕМЕННАЯ: сохраняем рез-т f(n-1) в rbx

	# Вычисление и вызов fibonacci(n-2)
	movl	-20(%rbp), %eax   # eax = n
	subl	$2, %eax          # eax = n - 2
	movl	%eax, %edi        # edi = n-2 (аргумент)
	call	_Z9fibonaccii     # вызов fibonacci(n-2), рез-т в rax

	# Сложение результатов двух вызовов
	addq	%rbx, %rax        # rax = fibonacci(n-2) + fibonacci(n-1)

.L3:
	movq	-8(%rbp), %rbx    # Восстанавливаем rbx
	leave                     # mov rsp, rbp; pop rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1976:
	.size	_Z9fibonaccii, .-_Z9fibonaccii

# ФУНКЦИЯ main
	.section	.rodata
.LC0:
	.string	": "            # <-- СТРОКОВАЯ КОНСТАНТА ": "
	.text
	.globl	main
	.type	main, @function
main:
.LFB1977:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx              # rbx будет временной переменной
	subq	$24, %rsp
	.cfi_offset 3, -24

	movl	$6, -20(%rbp)     # ПЕРЕМЕННАЯ n = 6 (в стеке по rbp-20)

	movl	-20(%rbp), %eax   # eax = n
	leaq	_ZSt4cout(%rip), %rdx  # rdx = адрес cout
	movl	%eax, %esi        # esi = n (второй аргумент operator<<)
	movq	%rdx, %rdi        # rdi = cout (первый аргумент)
	call	_ZNSolsEi@PLT     # вызов cout << n

	movq	%rax, %rdx        # rdx = возвращенный ostream& (cout)
	leaq	.LC0(%rip), %rax  # rax = адрес строки ": "
	movq	%rax, %rsi        # rsi = ": "
	movq	%rdx, %rdi        # rdi = ostream&
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT  # cout << ": "

	movq	%rax, %rbx        # ПЕРЕМЕННАЯ: сохраняем ostream& в rbx
	movl	-20(%rbp), %eax   # eax = n
	movl	%eax, %edi        # edi = n
	call	_Z9fibonaccii     # вызов fibonacci(6), результат в rax
	movq	%rax, %rsi        # rsi = результат fibonacci
	movq	%rbx, %rdi        # rdi = сохраненный ostream&
	call	_ZNSolsEy@PLT     # cout << fibonacci(6)

	movl	$0, %eax          # return 0
	movq	-8(%rbp), %rbx    # Восстанавливаем rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1977:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.1 20260209"
	.section	.note.GNU-stack,"",@progbits
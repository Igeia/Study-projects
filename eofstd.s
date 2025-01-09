.globl main
.type main, @function

.section .data
input_format:
	.string "%d"
prompt:
	.string "Enter a number. Odd numbers will invoke exponent, even will invoke factorial: "
output_format:
	.string "%d\n"
prompt_continue:
	.string "Continue? (Y/N) "
input_char:
	.string " %c"
.lcomm char_ptr, 1

.section .text
.equ NUMBER, -8

main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

loop:
	leaq prompt, %rdi
	xorq %rax, %rax
	call printf

	leaq input_format(%rip), %rdi
	leaq NUMBER(%rbp), %rsi
	xorq %rax, %rax
	call scanf

	movq NUMBER(%rbp), %rdi
	call eof

	leaq output_format, %rdi
	movq %rax, %rsi
	xorq %rax, %rax
	call printf

ask_to_continue:
	leaq prompt_continue, %rdi
	xorq %rax, %rax
	call printf

	leaq input_char, %rdi
	leaq char_ptr, %rsi
	xorq %rax, %rax
	call scanf
	
	cmpb $'n', char_ptr
	je finish
	cmpb $'N', char_ptr
	je finish

	cmpb $'y', char_ptr
	je loop
	cmpb $'Y', char_ptr
	je loop

	jmp ask_to_continue

finish:
	leave
	ret

.globl main

.section .data
filename:
	.ascii "random_data.txt\0"
filemode:
	.ascii "w\0"

prompt:
	.ascii "Enter a number to get its factorial: \0"
scan:
	.ascii "%d\0"
result:
	.ascii "The factorial of %d is %d.\n\0"
path_to_result:
	.ascii "The result has been saved to '%s'.\n\0"

.section .text
.equ FILE_PTR, -8
.equ FACT_NUM, -16
.equ FACT_RESULT, -24

main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	movq stdout, %rdi
	movq $prompt, %rsi
	movq $0, %rax
	call fprintf

	movq $filename, %rdi
        movq $filemode, %rsi
        call fopen

	movq %rax, FILE_PTR(%rbp)

	movq stdin, %rdi
	movq $scan, %rsi
	leaq FACT_NUM(%rbp), %rdx
	movq $0, %rax
	call fscanf

	movq FACT_NUM(%rbp), %rdi
	call factorial
	pushq %rax

	movq stdout, %rdi
        movq $path_to_result, %rsi
	movq $filename, %rdx
        movq $0, %rax
        call fprintf

	movq FILE_PTR(%rbp), %rdi
	movq $result, %rsi
	movq FACT_NUM(%rbp), %rdx
	movq FACT_RESULT(%rbp), %rcx
	movq $0, %rax
	call fprintf

	movq FILE_PTR(%rbp), %rdi
	call fclose

	movq $0, %rax
	leave
	ret

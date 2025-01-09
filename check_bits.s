.globl _start
.section .data
val_1:
	.quad 5
val_2:
	.quad 46
val_3:
	.quad 252

.section .text
_start:
	movq val_1, %rax
	lahf
	movq val_2, %rdi
	testq %rdi, %rax
	je found
	movq val_3, %rdi
	testq %rdi, %rax
	je found_2

	movq $0, %rdi
	movq $60, %rax
	syscall
found:
	movq val_2, %rdi
	movq $60, %rax
	syscall
found_2:
	movq val_3, %rdi
	movq $60, %rax
	syscall

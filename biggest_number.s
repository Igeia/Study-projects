.globl _start

.section .data
num_of_nums:
	.quad 8
nums:
	.quad 323, 643, 0, 5, 31, 2, 155, 175

.section .text
_start:
	movq num_of_nums, %rcx
	# Assume the first element to be the smallest
	movq nums-8(,%rcx,8), %rdi

	# Check if no more nums in the array
	cmp $0, %rcx
	je endloop

loop:
	movq nums-8(,%rcx,8), %rax
	cmp %rdi, %rax
	jae loopcontrol

	movq %rax, %rdi

loopcontrol:
	loopq loop

endloop:
	movq $60, %rax
	syscall

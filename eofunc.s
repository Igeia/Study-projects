.globl eofunction
.type eofunction, @function
.equ PARAM, -8

.section .data
even:
        .ascii "Even\n"
even_end:
.equ e_len, even_end - even

odd:
        .ascii "Odd\n"
odd_end:
.equ o_len, odd_end - odd

.section .text
eofunction:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	movq %rdi, PARAM(%rbp)
	movq PARAM(%rbp), %rax
        testq $0b1, %rax
        jnz n_odd

        movq $1, %rax
        movq $1, %rdi

        movq $even, %rsi
        movq $e_len, %rdx
        syscall

        leave
	ret

n_odd:
        movq $1, %rax
        movq $1, %rdi

        movq $odd, %rsi
        movq $o_len, %rdx
        syscall

	leave
	ret

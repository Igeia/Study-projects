.globl main

.section .data
filename:
	.ascii "about_sally.txt\0"
openmode:
	.ascii "w\0"

formatstring1:
	.ascii "The age of %s is %d.\n\0"
sallyname:
	.ascii "Sally\0"
sallyage:
	.quad 53

formatstring2:
	.ascii "%d and %d are %s's favorite numbers.\n\0"
joshname:
	.ascii "Josh\0"
joshfavfirst:
	.quad 7
joshfavsecond:
	.quad 13

.section .text
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp

	movq $filename, %rdi
	movq $openmode, %rsi
	call fopen

	# Saving file pointer
	movq %rax, -8(%rbp)

	# Write the first string to the file
	movq -8(%rbp), %rdi
	movq $formatstring1, %rsi
	movq $sallyname, %rdx
	movq sallyage, %rcx
	movq $0, %rax
	call fprintf

	# Write the second string to the file
	movq -8(%rbp), %rdi
        movq $formatstring2, %rsi
        movq joshfavfirst, %rdx
        movq joshfavsecond, %rcx
	movq $joshname, %r8
        movq $0, %rax
        call fprintf

	# Close the file
	movq -8(%rbp), %rdi
	call fclose

	movq $0, %rax
	leave
	ret

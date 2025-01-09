.globl factorial
.type factorial, @function

.text
factorial:
	# No stack frame, call factorial_internal

	# %rdi already has a number,
	# value_so_far is set to 1
	movq $1, %rsi

	# We can eliminate this as a tail-call, too
	jmp factorial_internal

factorial_internal:
	# %rdi has number,
	# %rsi has value_so_far
	
	cmpq $1, %rdi
	je factorial_internal_complete

	# Multiply number and value_so_far
	movq %rsi, %rax
	mulq %rdi

	# Get next value
	decq %rdi			# Number
	movq %rax, %rsi		# value_so_far

	# Tail-call elimination
	jmp factorial_internal

factorial_internal_complete:
	# Base case - return value_so_far
	movq %rsi, %rax
	ret

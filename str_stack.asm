; reversing a string using the stack

;=======================Main part==============================

main:			call prompt_char_number			; prompt for entering char amount
			ldi prompt_string			; load the string and display in console
			sout
			ld count				; load the count meter and start loop
			brz str_inverted			; branch to the inversion operation after all chars are entered
			sub @1
			st count
			asp -1					; reserve one spot for a char on the stack
			ain					; enter a char
			str 0					; store the char at the relative address on the stack
			br 0x3					; loop back to the counter at address 0x3 (enumeration starts from main)

str_inverted:		call result_out				; display the reversed string
			ld str_inv_count			; load the counter before outputting all chars from the stack
			brz end					; branch to end when done
			sub @1
			st str_inv_count
			ldr 0					; load the char on top of the stack
			aout					; display the character
			asp 1					; pop the item on top of the stack
			br 12					; branch back to address 0x12
		
end:			halt					; terminate program

;=====================End of main part=========================

count:			.word 0					; counter for the main
str_inv_count:		.word 0					; counter for the string reversal loop
@1:			.word 1					; decimal 1

prompt_char_number:	ldi prompt_char_count			; load the char count prompt
			sout					; display the prompt
			din					; input a decimal
			st count				; st the decimal to count and str_inv_count w/o hardcoding the values
			st str_inv_count
			ret					; return from the subroutine

result_out:		ldi result				; load the string with the result
			sout					; display the string
			ret					; return from the subroutine

result:			.stringz "Inverted string: "
prompt_string:		.stringz "Enter a string to reverse: "
prompt_char_count:	.stringz "Enter your string's character amount (including spaces and punctuation): "

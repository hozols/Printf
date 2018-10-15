

// Print a given number to it's string representation
// @param %rdi - Number to print
printNum:

	push %rsi
	push %r12
	push %r14

	// Use %r12 as counter of the length of the number
	movq $0, %r12

	// Check if the number is negative or positive
	// If it's negative, convert it to a positive and print the minus sign
	// If it's positive, continue
	cmpq $0, %rdi
	jg goTroughNumber

	// Deal with negative number
	movq %rdi, %rax
	movq $-1, %rdi
	mulq %rdi
	movq $negationSign, %rdi
	call printChar
	movq %rax, %rdi

	goTroughNumber:

	// Check if it's less than 10. If so, print it and finish the recursion
	cmpq $10, %rdi
	jl pr

	// If bigger, divide the number by 10 and display the remainder of the division
	addq $1, %r12
	movq $0, %rdx
	movq %rdi, %rax
	movq $10, %rbx

	//Execute division
	divq %rbx

	// Move result temporarily to r14
	movq  %rax, %r14

	// Convert the digit to string
	movq %rdx, %rdi
	call digitToString

	// Push the string to the stack (later digits will be printed in reverse order)
	push %rax

	// Execute division again
	movq %r14, %rdi
	jmp goTroughNumber

	pr:

	call digitToString

	push %rax

	printAllDigitsLoop:
	cmpq $0, %r12
	jl finishPrinting


	pop %rdi 
	call printChar
	subq $1, %r12
	jmp printAllDigitsLoop

	finishPrinting:

	pop %r14
	pop %r12
	pop %rsi
	ret $0

// Print a given char
// @param %rdi - char to print
printChar:
	
	// Preserve old value of used registers here
	push %rsi
	push %rax
	push %rdi
	push %rdx

	// Print a single character (holded in %rdi)
	movq %rdi, %rsi
	movq $1, %rax
	movq $1, %rdi
	movq $1, %rdx

	syscall


	pop %rdx
	pop %rdi
	pop %rax
	pop %rsi

	ret


// Converts a given digit to the actual symbol and returns it
// @param %rdi = Digit to convert
// @ret %rax = Converted string 
digitToString:


	// Convert number to actual ASCII code
	addq $48, %rdi

	// Read the string of numbers as a list of chars         
	leaq numstr,%rsi    

	readNextDigit:

	// Null rax
	movq $0, %rax

	// read byte of string, then automaticaly increment position in string (next byte)
	lodsb               

	// Rsi holds the actual memory address to the char
	// rax holds the asci code of the char

	addq $-1, %rsi

	// Check if the ascii code is the same as the one provided, if not, try with the next char
	cmpq %rdi,%rax          
	jne   checkAgainNum    

	// If equal, return the char and exit the subroutine
	movq %rsi, %rax

	ret   

	// If not equal, add 1 to the memory address (next char) and try again
	checkAgainNum:

	addq $1,  %rsi
	movq %rsi, %rax

	jmp  readNextDigit            # repeat procedure


.data
numstr: .asciz "0123456789"  
negationSign: .asciz "-"

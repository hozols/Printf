// Assignment 4b
// Team member 1: Herman Ozols - 4929179
// Team member 2: Radoslav Stefanov - 4914244
// Copyright 2018 TU DELFT Computer Organization Course 
// All rights reserved :)

.data
str: .asciz "My name is %s. I think I'll get a %u for my exam. What does %d do? %s %s or %d And %% \n"	# if there is '\n', then it increment length by 1
newline: .string " - "
personalDetails: .asciz "\n %d \n"
hello: .asciz "Herman"
percentSign: .asciz "%"
str2: .asciz "Hello %s %d %d %k test \n"

hello2: .asciz "Herman2"
hello3: .asciz "Herman3"
hello4: .asciz "Herman4"
hello5: .asciz "Herman5"
hello6: .asciz "Herman6"
hello7: .asciz "Herman7"
hello8: .asciz "Herman7"

.globl main

#include "printNumber.S"

main:
	movq $str, %rdi
	movq $hello, %rsi
	movq $43, %rdx
	movq $587, %rcx	
	movq $hello2, %r8
	movq $hello2, %r9
	push $42


	call printf_hr


	call exit

printf_hr:

	// Add all possible parameters to the stack
	pop %r15
	push %r9
	push %r8
	push %rcx
	push %rdx
	push %rsi

	movq %rdi,%rsi

	printfReadNextSymbol:

	// Null rax
	movq $0, %rax

	// read byte of string, then automaticaly increment position in string (next byte)
	lodsb				

	// Get the previous symbol and print it (as lodsb starts from the second char) 
	addq $-1, %rsi
	movq %rax, %r12

	// Check if the char is a percent sign, if so, deal with it in checkPercentSign
	cmpq $37,%r12
	je   checkPercentSign	

	// Check if end of string is reached, complete the subroutine
	cmpq $0, %r12
	je terminateReading

	// Print the current character
	movq %rsi, %rdi
	call printChar

	// Bring back the subtracted value to rsi
	addq $1,  %rsi

	jmp  printfReadNextSymbol			# repeat procedure

	terminateReading:
	ret
	

// Check the value after the percent sign and execute the proper method
checkPercentSign:

	// Get next symbol
	addq $1, %rsi

	//  read byte of string, then automaticaly increment position in string (next byte)
	lodsb	
		
	// Preserve rax's value in r14 for future usage of rax
	movq %rax, %r14

	movq %r14, %rdi

	// Check if next char is s ()
	cmpq $115, %r14
	je printString

	// Check if next char is u (unsigned number)
	cmpq $117, %r14
	je printDigit

	// Check if next char is d (signed decimal)
	cmpq $100, %r14
	je printDigit

	// Check if next char is % (Print a percent)
	cmpq $37, %r14
	je printPercent

	// Default code - prints the percent sign and the formatter 
	addq $-1, %rsi	
	call printPercent
	movq %rsi, %rdi
	call printChar


	jmp printfReadNextSymbol


printPercent:
	// Print a percent sign
	movq $percentSign, %rdi
	call printChar
	jmp printfReadNextSymbol

printDigit:
	
	// Print a number 
	pop %rdi
	call printNum

	jmp printfReadNextSymbol

printString:
	
	// Print a string

	// GGet the next user input
	pop %rax

	// Preserve the previous value of rsi in the stack
	push %rsi

	// Adjust the parameters for lodsb
	movq %rax,%rsi
	movq $0, %rax

	// Read the string char by char and print every single chart
	readNextPartOfString:
	lodsb

	// Start from the first char
	subq $1, %rsi
 
	// Terminate string reading if end of string is reached
	cmpq $0, %rax
	je terminateStringPrinting


	movq %rsi, %rdi
	call printChar

	addq $1, %rsi
	jmp readNextPartOfString

	terminateStringPrinting:

	pop %rsi
	jmp printfReadNextSymbol
	

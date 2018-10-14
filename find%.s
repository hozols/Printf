.data
str: .asciz "My name is %s. I think I'll get a %u for my exam. What does %d do? And % \n"	# if there is '\n', then it increment length by 1
newline: .string " - "
personalDetails: .asciz "\n %d \n"
hello: .asciz "Herman"
percentSign: .asciz "%"
str2: .asciz "Hello %s %s %s %s %s %s %s \n"

hello2: .asciz "Herman2"
hello3: .asciz "Herman3"
hello4: .asciz "Herman4"
hello5: .asciz "Herman5"
hello6: .asciz "Herman6"
hello7: .asciz "Herman7"

.globl main

#include "printNumber.S"

main:
	movq $str2, %rdi
	movq $hello, %rsi
	movq $hello2, %rdx
	movq $hello3, %rcx
	movq $hello4, %r8
	movq $hello5, %r9
	push $hello6
	push $hello7

	call printf_hr


	call exit

printf_hr:
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

	movq %rsi, %rdi
	call printChar

	addq $1,  %rsi
	movq %rsi, %rax

	jmp  printfReadNextSymbol			# repeat procedure

	terminateReading:
	ret
	

// Check the value after the percent sign and execute the proper method
checkPercentSign:

	// Get next symbol
	addq $1, %rsi

	//  read byte of string, then automaticaly increment position in string (next byte)
	lodsb				
	movq %rax, %r14

	movq %r14, %rdi

	cmpq $115, %r14
	je printString

	cmpq $117, %r14
	je printDigit

	cmpq $100, %r14
	je printDigit

	cmpq $32, %r14
	je printPercent

	call printNum


	continuePercent: 

	movq %rsi, %rax

	jmp printfReadNextSymbol


printPercent:
	movq $percentSign, %rdi
	call printChar
	jmp continuePercent

printDigit:

	pop %rdi
	call printNum

	jmp continuePercent

printString:

	pop %rax

	push %rsi

	movq %rax,%rsi
	movq $0, %rax

	readNextPartOfString:
	lodsb

	subq $1, %rsi

	cmpq $0, %rax
	je terminateStringPrinting


	movq %rsi, %rdi
	call printChar

	addq $1, %rsi
	jmp readNextPartOfString

	terminateStringPrinting:

	pop %rsi
	jmp continuePercent
	

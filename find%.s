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

	movq $0,%r13			
	movq %rdi,%rsi		# effective address of string to %esi

	abc:


	movq $0, %rax

	lodsb				# read byte of string, then automaticaly increment position in string (next byte)

	addq $-1, %rsi
	movq %rax, %r12

	cmpq $37,%r12
	je   checkPercentSign	

	// Check if end of string is reached, complete the subroutine
	cmpq $0, %r12
	je terminateReading

	addq $1,%r13			# counter
	

	movq $1, %rax
	movq $1, %rdi
	movq $1, %rdx
 
	syscall

	addq $1,  %rsi
	movq %rsi, %rax

	jmp  abc			# repeat procedure

	terminateReading:
	ret
	

checkPercentSign:

	
	addq $1, %rsi
	lodsb				# read byte of string, then automaticaly increment position in string (next byte)
	movq %rax, %r14

	//addq $-1, %rsi
	//movq %rax, %r12
	//cmpq $115, %r14


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
	//addq $1, %rsi
	movq %rsi, %rax

	jmp abc

	

	//movq $0, %rax
	//movq $personalDetails, %rdi
	//movq %r11, %rsi
	//call printf

	// movq $1, %rax
	// movq $1, %rdi
	// movq $str , %rsi
	// movq $30, %rdx
 
	// syscall
	//jmp abc

	//call exit

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

	//lodsb				# read byte of string, then automaticaly increment position in string (next byte)
	//addq $1, %rax

	terminateStringPrinting:

	pop %rsi
	jmp continuePercent
	

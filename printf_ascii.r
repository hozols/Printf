.globl main

main:

	movq $0,%r11			
	leal str,%esi			# effective address of string to %esi

	abc:

	// movq $1, %rax
	// movq $1, %rdi
	// movq $1, %rdx
	// movq $newline , %rsi
	// movq $3, %rdx

	//syscall

	movq $0, %rax

	lodsb				# read byte of string, then automaticaly increment position in string (next byte)

	movq %rax, %r12
	movq $1, %rax
	movq $1, %rdi
	movq $1, %rdx
 
	syscall

	movq %rsi, %rax


	cmpq $37,%r12			# if readed byte equal 0, so end of string reached
	je   continue				
	addq $1,%r11			# counter
	jmp  abc			# repeat procedure

	continue:
	//decq %r11

	movq $0, %rax
	movq $personalDetails, %rdi
	movq %r11, %rsi
	call printf

	// movq $1, %rax
	// movq $1, %rdi
	// movq $str , %rsi
	// movq $30, %rdx
 
	// syscall

	call exit

.data
str: .asciz " This is some real %d decimal haha \n"	# if there is '\n', then it increment length by 1
newline: .string " - "
personalDetails: .asciz "\n %d \n"

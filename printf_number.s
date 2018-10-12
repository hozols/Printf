.globl main

personalDetails: .asciz "%d \n"

main:
	movq $947, %rdi
	call printNum
	// movq $10, %rbx

	// movq $0, %rdx
	// movq $10, %rcx

	// //mov $10, %ds
	// div %rbx


	// movq %rdx, %rsi
	// movq $0, %rax
	// movq $personalDetails, %rdi
	
	// call printf

	pop %rax
	pop %rax 
	pop %rax
	call exit

printNum:
	
	cmpq $10, %rdi
	jl pr

	movq $0, %rdx
	movq %rdi, %rax
	movq $10, %rbx

	divq %rbx

	movq  %rax, %r14

	movq %rdx, %rdi
	call printDigit

	movq %r14, %rax

	movq %rax, %rdi
	call printNum

	ret



	pr:

	call printDigit

	ret


printDigit:

    movq %rdi, %rax

    addq $48, %rdi

    movq $0,%r13            
    leaq str,%rsi           # effective address of string to %esi

    abc:


    movq $0, %rax

    lodsb               # read byte of string, then automaticaly increment position in string (next byte)

    addq $-1, %rsi
    movq %rax, %r12

    cmpq %rdi,%r12           # if readed byte equal 0, so end of string reached
    jne   continue    
        

    addq $1,%r13            # counter
    movq $1, %rax
    movq $1, %rdi
    movq $1, %rdx
 
    syscall

    //push %rsi
    movq %rsi, %rax

    ret   

    continue:

    addq $1,  %rsi
    movq %rsi, %rax

    jmp  abc            # repeat procedure


   // call exit

.data
str: .asciz "0123456789"  # if there is '\n', then it increment length by 1
newline: .string " - "



hello:
     .string "Hello world!\n"


.globl main
main:

	movq $1, %rax
	movq $1, %rdi
	movq $hello , %rsi
	movq $14, %rdx
 
	syscall

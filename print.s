    .text
  string1:  .asciz  "Assembly is fun as fuck \n"

  
   .global main


    main:
        movq  $string1, %rdi
        xor   %rcx, %rcx
        not   %rcx
        xor   %al, %al
        cld
        repnz scasb
        not   %rcx
        dec   %rcx
        movq  %rcx, %rdx

        movq  $string1, %rsi
        mov   $1, %rax
        mov   %rax, %rdi
        syscall

        xor   %rdi, %rdi
        mov   $0x3c, %rax
        syscall

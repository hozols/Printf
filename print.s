    .text
  string1:  .asciz  "Assembly is fun as fuck \n"

  
   .global main


    main:
        movq  $string1, %rdi           # string1 to destination index
        xor   %rcx, %rcx               # zero rcx
        not   %rcx                     # set rcx = -1
        xor   %al, %al                 # zero the al register (initialize to NUL)
        cld                            # clear the direction flag
        repnz scasb                    # get the string length (dec rcx through NUL)
        not   %rcx                     # rev all bits of negative results in absolute value
        dec   %rcx                     # -1 to skip the null-terminator, rcx contains length
        movq  %rcx, %rdx               # put length in rdx

        movq  $string1, %rsi           # string1 to source index
        mov   $1, %rax                 # set write to command
        mov   %rax, %rdi               # set destination index to rax (stdout)
        syscall                        # call kernel

        xor   %rdi, %rdi               # zero rdi (rdi hold return value)
        mov   $0x3c, %rax              # set syscall number to 60 (0x3c hex)
        syscall                        # call kernel

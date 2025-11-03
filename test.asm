  
               section .data
            cStr db "Hello world"
            CLEN equ $ - cStr
               section .bss
             msg resb 1
                section .text
                extern mem_display
                extern mem_copy
                global _start
_start:
    mov rdx, 0x00000108h
    mov rax, 0x33300020h
    mov disv, 0x00000100h
    div disv
_exit:
    mov eax, 1
    int 0x80

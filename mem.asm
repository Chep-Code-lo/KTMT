
                section .text
                extern write_bin
                extern write_hex
                extern write_hex_al
                extern writeChar
                extern newline
                extern space 
                global mem_display
                global mem_copy
mem_display:
    push ebp
    mov ebp, esp
    push esi
    push ecx
    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]
_loop:
    lodsb
    call write_hex
    call space
    loop _loop
    call newline
    pop ecx
    pop esi
    leave
    ret
mem_copy:
    push ebp
    mov  ebp, esp
    push ecx
    push esi
    push edi

    mov esi, [ebp+8]    
    mov edi, [ebp+12]   
    mov ecx, [ebp+16]  
    cld
    rep movsb          
    pop edi
    pop esi
    pop ecx
    leave
    ret
mem_swap:
mem_encode:
_exit:
    mov eax, 1
    int 0x80

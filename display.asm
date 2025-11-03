
%macro writeStr 2
    push eax
    push ebx
    push edx
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
    pop ecx
    pop edx
    pop ebx
    pop eax
%endmacro   
               section .data
               section .bss
             msg resb 1
                section .text
                global write_bin
                global write_hex
                global write_hex_al
                global writeChar
                global newline
                global space
_exit:
    mov eax, 1
    int 0x80
space:
    mov al, ' '
    call writeChar
    ret
newline:
    mov al, 10
    call writeChar
    ret
writeChar:
    mov     [msg], al
    writeStr msg, 1
    ret
write_hex_al:
    cmp   al, 9
    jbe   .digit ;Nếu Al <= 9 
    add   al, 55
    jmp  .out
.digit:
    add  al, '0'
.out:
    call writeChar
    ret
write_hex:
    push ebx
    mov  bh, al
    shr al, 4
    call write_hex_al
    mov al, bh
    and al, 0x0F
    call write_hex_al
    pop ebx
    ret
write_bin:
    push eax
    push ecx
    push ebx
    mov bl, al
    mov ecx, 8
.bin_loop:
    cmp ecx, 4
    jne .no_space
    call space
.no_space:
    shl bl, 1
    mov al, '0'
    adc al, 0
    call writeChar
    loop .bin_loop
    pop ecx
    pop ebx
    pop eax
    ret




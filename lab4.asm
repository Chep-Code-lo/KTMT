bits 32
                section .data   
            bItstr db "1001 1101", 0
            bArr  db 5, 8, 88, 1, 12, 50, 7
            bLen  equ $ - bArr
            iStr  db "Today is monday", 0
            ILEN  equ $ - iStr
            HLEN  equ $ - (ILEN-1)/2
            sbits db "01100011", 0
            msg   db "Hello", 10
            mLen  equ $ - msg
            key   equ 1110000b
            orig  db 0x25, 0x99, 0xDF, 0x56, 0x00, 0x7E, 0x1D
            len   equ $ - orig
            rows  equ 3
            cols  equ 4
            mat   db 1, 2, 3, 4
                  db 5, 6, 7, 8
                  db 9, 10, 11, 12
            hexDigits db '0123456789ABCDEF'
            hexOut    db '00',10                  
            binOut    db '00000000',10         
            decOut    times 6 db 0  

                section .bss
            A           resw 19
            bits_al     resb 9
            value       resd 1
            even_cnt    resd 1
            swap        resb len
            enc         resb 6
            row_sum     resw rows
            bItout      resb 10
            
                section .text
                global _start
_start:
        xor ecx, ecx
.gen_inc:
        mov eax, ecx
        inc eax
        shl eax, 4
        mov [A + ecx*2], ax
        inc ecx
        cmp ecx, 9
        jl .gen_inc

        xor ecx, ecx
.gen_dec:
        mov eax, 0x190
        mov edx, ecx
        shl edx, 4
        sub eax, edx
        mov [A + 18 + ecx*2], ax
        inc ecx
        cmp ecx, 10
        jl .gen_dec
_case1:
        mov ax, 0x1234
        mov dx, 0x5678
        movzx eax, ax
        shl edx, 16
        or eax, edx
        bswap eax
        rol eax, 16
        mov ebx, eax
_case2:
        mov esi, bItstr
        xor ebx, ebx
        mov ecx, 8
.next_ch:
        lodsb
        cmp al, ' '
        je .next_ch
        cmp al, '0'
        je .bit0
        cmp al, '1'
        je .bit1
        jmp .next_ch
.bit0:
        shl bl, 1
        dec ecx
        jnz .next_ch
        mov al, bl
        jmp .get
.bit1:
        shl bl, 1
        or bl, 1
        dec ecx
        jnz .next_ch
        mov al, bl
.get:
        ;in ra 
        mov dl, al
        mov edi, bItout
        mov ecx, 8
        cld
.b:
        cmp ecx, 4
        jne .no_space
        mov al, ' '
        stosb
.no_space:
        shl dl, 1
        mov al, '0'
        adc al, 0
        stosb
        loop .b
        mov byte[edi], 10;
        mov eax, 4
        mov ebx, 1
        mov ecx, bItout
        mov edx, 10
        int 0x80
_case3:
        mov al, 11001010b
        mov edi, bits_al
        mov ecx, 8
        mov bl, al
.conv:
        mov byte[edi], '0'
        shl bl, 1
        adc byte[edi], '0'
        inc edi
        loop .conv
        mov byte[bits_al + 8], 0
_case4:
        xor eax, eax
        mov esi, sbits
.cal:
        mov bl, [esi]
        cmp bl, 0
        je .done_parse
        shl eax, 1
        cmp bl, '1'
        jne .next
        inc eax 
.next:
        inc esi
        jmp .cal
.done_parse:
        mov [value], eax
_case5:
        xor ecx, ecx
        xor edx, edx
.count_even:
        cmp ecx, bLen
        jge .ce_done
        mov al, [bArr+ecx]
        test al, 1
        jnz .odd
        inc edx
.odd:
        inc ecx
        jmp .count_even
.ce_done:
        mov [even_cnt], edx
_case6:
        xor ecx, ecx
.rev:
        cmp ecx, ILEN
        jge .done_rev
        mov al, [iStr+ecx]
        mov edx, ILEN - 1
        sub edx, ecx
        mov [swap + edx], al
        inc ecx
        jmp .rev
.done_rev:
        mov ecx, ILEN
        lea esi, [swap]
        lea edi, [iStr]
        cld
        rep movsb
_case71:
        mov ecx, (ILEN - 1)/2
        mov esi, 0
        mov edi, ILEN -2
_bloop:
        mov al, [iStr + esi]
        mov bl, [iStr + edi]
        mov [iStr + esi], bl
        mov [iStr + edi], al
        inc esi
        dec edi
        loop _bloop
_case72:
        mov ecx, mLen-1
        xor esi, esi
_encode:
        xor byte[msg + esi], key
        inc esi
        loop _encode
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, mLen
        int 0x80
_pr1:
        mov ecx, mLen-1
        xor esi, esi
_decode:
        xor byte[msg + esi], key
        inc esi
        loop _decode
_pr2:
        mov eax, 4
        mov ebx, 1
        mov ecx, msg
        mov edx, mLen
        int 0x80
_case8:
        xor edi, edi
        xor eax, eax
.row_loop:
        cmp edi, rows
        jge _case9
        mov ebx, edi
        imul ebx, cols
        lea esi, [mat + ebx]
        xor eax, eax
        mov ecx, cols
.col_loop:
        movzx edx, byte[esi]
        add eax, edx
        inc esi
        loop .col_loop
        mov [row_sum + edi*2], ax
        inc edi
        jmp .row_loop

_case9:
        mov dl, 15
        call print_hex8
_case10a:
        mov dl, 48
        call print_bin8
_case10b:
        mov dx, 1234
        call print_dec16
_case10c:
_exit:
        mov eax, 1
        int 0x80
puts:
    mov eax,4           
    mov ebx,1     
    int 0x80
    ret
print_hex8:
    movzx eax, dl          
    mov bl, al             
    mov bh, al            
    shr bl, 4              
    and bh, 0x0F            
    movzx ecx, bl
    mov dl, [hexDigits+ecx]
    mov [hexOut], dl
    movzx ecx, bh
    mov dl, [hexDigits+ecx]
    mov [hexOut+1], dl
    mov byte [hexOut+2], 10 
    lea ecx, [hexOut]
    mov edx, 3
    jmp  puts
print_bin8:
    mov bl, dl             
    lea edi, [binOut]
    mov ecx, 8
.bin_loop:
    shl bl, 1               
    setc al                
    add al, '0'           
    stosb                   
    loop .bin_loop
    mov byte [edi], 10    
    lea ecx, [binOut]
    mov edx, 9
    jmp  puts
print_dec16:
    movzx eax, dx           
    lea edi, [decOut+5]    
    mov byte [edi], 10     
    cmp eax, 0
    jne .conv
    mov byte [decOut], '0'
    mov byte [decOut+1], 10
    lea ecx, [decOut]
    mov edx, 2
    jmp puts
.conv:
    .loop:
        xor edx, edx
        mov ebx, 10
        div ebx             
        add dl, '0'
        dec edi
        mov [edi], dl
        test eax, eax
        jnz .loop
    lea ecx, [edi]
    lea edx, [decOut+6]
    sub edx, ecx
    jmp puts
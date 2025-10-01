        section .data

bNum    db 5
wNum    dw -128
dNum    dd 0x12345678
List    dw 0x1000, 0x2000, 0x3000, 0x4000, 0x5000
Hello   db "Netwide Assembly", 10
len     equ $ - Hello
lenList equ 10
line_of_a times 40 db "a"
a       dw 0x2445
b       dw 0x10

        section .bss
    bArr        resb 5
    wArr        resw 5
    cArr        resb 20
    Tong        resd 1
    Hieu        resw 1
    Tich        resd 1
    Thuong      resw 1
    Du          resw 1
    sum         resd 1

        section .text
        global _start
_start:
        xor eax, eax
        mov ax, [a]
        add ax, [b]
        mov [Tong], eax
_tong:
        mov ax, [a]
        sub ax, [b]
        mov [Hieu], ax
_hieu:
        mov ax, [a]
        imul word[b]
        mov [Tich], ax
        mov [Tich + 2], dx
_tich:
        mov ax, [a]
        xor dx, dx
        div word[b]
        mov [Thuong], ax
        mov [Du], dx
_thuong:
        mov ecx, 5
        mov al, [bNum]
        mov si, 0
_aloop:
        mov [bArr + esi], al
        inc esi
        loop _aloop
_a45:
        mov ecx, 5
        mov esi, List
        mov edi, wArr
        cld 
        rep movsw
_b45:
        mov ecx, len
        mov esi, Hello
        mov edi, cArr
        cld
        rep movsb
_c45:
        mov eax, 4
        mov ebx, 1
        mov ecx, cArr
        mov edx, len
        int 0x80
_d45:
        mov ecx, lenList
        mov esi, List
        xor eax, eax
_sumLoop:
        movzx ebx, word[esi]
        add eax, ebx
        add esi, 2
        loop _sumLoop
        mov [sum], eax
_exit:
        mov eax, 1
        int 0x80



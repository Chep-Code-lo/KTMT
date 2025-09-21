        section .data

bNum    db 5
wNum    dw -128
dNum    dd 0x12345678
List    dw 0x1000, 0x2000, 0x3000, 0x4000, 0x5000
Hello   db "Netwwide Assembly"
line_of_a times 40 db "a"
a       dw 0x2006
b       dw 0x24

        section .bss
    bArr        resb 5
    wArr        resw 5
    cArr        resb 20
    Tong        resd 1
    Hieu        resw 1
    Tich        resd 1
    Thuong      resw 1
    Du          resw 1

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

        mov eax, 1
        int 0x80



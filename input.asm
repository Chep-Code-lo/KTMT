            section .data
prompt  db "Nhap ten cua ban: ",0
len     equ $ - prompt

hello   db "Xin chao, ", 0
hlen    equ $ - hello 

            section .bss
            name    resb 32

            section .text
            global main
main:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name
    mov edx, 32
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, hlen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 32
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80




            section .data
N       db "Nhap N: ", 0
ai      db "Nhap so: ", 0
sum     db "Sum = ", 0
nl      db 10

            section .bss
            inbuf   resb 256
            outbf   resb 32

            section .text
            global main
main:
    push dword N
    call print_cstr
    add esp, 4

    push dword 256
    push dword inbuf
    call read_line
    add esp, 8

    push dword inbuf
    call atoi32_signed
    add esp, 4
    mov ecx, eax
    xor ebx, ebx
.loop_nums:
    push dword ai
    call print_cstr
    add esp, 4
    push dword 256
    push dword inbuf
    call read_line
    add esp, 8

    push dword inbuf
    call atoi32_signed
    add esp, 4

    add ebx, eax
    loop .loop_nums

.after_loop:
    push dword sum
    call print_cstr
    add esp, 4

    push ex
    push dword outbf
    call itoa32_signed
    add esp, 8

    mov eax, 4
    mov ebx, 1
    int 0x80

    
    


%include 'in_out.asm'

SECTION .data
msg db "Результат: ",0

SECTION .text
global _start

_start:
    pop ecx
    pop edx
    sub ecx, 1
    mov esi, 0
    
next:
    cmp ecx, 0
    jz _end
    pop eax
    call atoi
    
    ; f(x) = 2x + 15 :
    mov ebx, eax
    add eax, eax
    add eax, 15
    
    add esi, eax
    dec ecx
    jmp next

_end:
    mov eax, msg
    call sprint
    mov eax, esi
    call iprintLF
    call quit

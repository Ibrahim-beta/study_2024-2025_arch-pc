%include 'in_out.asm'

SECTION .data
msg: DB 'Введите строку: ',0h

SECTION .bss
buf1: RESB 80

SECTION .text
GLOBAL _start
_start:
    ; --- Afficher le message ---
    mov eax, msg
    call sprintLF

    ; --- Lire le clavier ---
    mov ecx, buf1
    mov edx, 80
    call sread

    ; --- Afficher ce qui a été tapé ---
    mov eax, buf1
    call sprintLF

    ; --- Quitter ---
    call quit

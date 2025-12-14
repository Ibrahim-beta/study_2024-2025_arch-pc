%include 'in_out.asm'

SECTION .data
filename db 'readme.txt', 0h
msg db 'Введите строку для записи в файл: ', 0h
error_msg db 'Ошибка при создании файла!', 0h

SECTION .bss
contents resb 255

SECTION .text
global _start
_start:
    mov eax, msg
    call sprint

    mov ecx, contents
    mov edx, 255
    call sread

    mov ecx, 0644o    ; права: rw-r--r--
    mov ebx, filename
    mov eax, 8
    int 80h

    cmp eax, 0
    jl error

    mov esi, eax
    mov eax, contents
    call slen

    mov edx, eax
    mov ecx, contents
    mov ebx, esi
    mov eax, 4
    int 80h

    mov ebx, esi
    mov eax, 6
    int 80h

    call quit

error:
    mov eax, error_msg
    call sprintLF
    call quit

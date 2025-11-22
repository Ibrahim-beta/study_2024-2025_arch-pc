%include 'in_out.asm'

section .data
msg_x db "Введите x: ",0
msg_a db "Введите a: ",0
msg_res db "Результат f(x): ",0

section .bss
x resb 10
a resb 10

section .text
global _start
_start:

; --- Ввод x
mov eax, msg_x
call sprint
mov ecx, x
mov edx, 10
call sread
mov eax, x
call atoi
push eax

; --- Ввод a
mov eax, msg_a
call sprint
mov ecx, a
mov edx, 10
call sread
mov eax, a
call atoi
push eax

pop ebx   ; ebx = a
pop eax   ; eax = x

; --- Проверка условия
cmp eax, 4
jl cas_simple

; --- Случай x >= 4: 
mov ecx, ebx  ; 
mov ebx, eax  ; 
mov eax, 0    ; 
cmp ecx, 0
je affichage  

multiplication:
add eax, ebx  ; 
loop multiplication
jmp affichage

; --- Случай x < 4: x + 4
cas_simple:
add eax, 4

; --- Вывод
affichage:
push eax
mov eax, msg_res
call sprint
pop eax
call iprintLF

call quit

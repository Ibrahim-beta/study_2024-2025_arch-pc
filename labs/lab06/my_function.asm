%include 'in_out.asm'

SECTION .data
msg: DB 'Введите значение x: ',0
result: DB 'Результат: ',0

SECTION .bss
x: RESB 80

SECTION .text
GLOBAL _start
_start:

; Запрос ввода значения x
mov eax, msg
call sprint

mov ecx, x
mov edx, 80
call sread

; Преобразование введенной строки в число
mov eax, x
call atoi

; ===== ВЫЧИСЛЕНИЕ ВЫРАЖЕНИЯ f(x) = 18(x + 1)/6 =====

; Шаг 1: Вычисление (x + 1)
mov ebx, eax  ; сохраняем x в ebx
add ebx, 1    ; ebx = x + 1

; Шаг 2: Умножение 18 * (x + 1)
mov eax, 18   ; eax = 18
mul ebx       ; eax = 18 * (x + 1)

; Шаг 3: Деление на 6
mov ebx, 6    ; ebx = 6
xor edx, edx  ; обнуляем edx для корректного деления
div ebx       ; eax = 18(x + 1)/6

; ===== КОНЕЦ ВЫЧИСЛЕНИЙ =====

mov edi, eax ; сохраняем результат в edi

; Вывод результата на экран
mov eax, result
call sprint
mov eax, edi
call iprintLF

call quit

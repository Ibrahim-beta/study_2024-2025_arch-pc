# Лабораторная работа №7
# Команды безусловного и условного переходов в Nasm. Программирование ветвлений.

**Выполнил:** Ибрагим Хиссеин Гана
**Группа:** НПИьд 01-25 
**Вариант:** 16

## Цель работы
Изучение команд условного и безусловного переходов в ассемблере NASM.

## Выполнение работы

### 1. Программа с безусловными переходами (lab7-1.asm)

**Код программы:**
```asm
%include 'in_out.asm'

SECTION .data
msg1: DB 'Сообщение № 1',0
msg2: DB 'Сообщение № 2',0
msg3: DB 'Сообщение № 3',0

SECTION .text
GLOBAL _start
_start:

jmp _label2

_label1:
    mov eax, msg1
    call sprintLF

_label2:
    mov eax, msg2
    call sprintLF

_label3:
    mov eax, msg3
    call sprintLF

_end:
    call quit

Результат выполнения:

Сообщение № 2
Сообщение № 3

Анализ: Программа демонстрирует работу команды jmp для безусловного перехода. Из-за перехода jmp _label2 сообщение №1 не выводится.

2. Программа с условными переходами (lab7-2.asm)
Код программы:
%include 'in_out.asm'

section .data
msg1 db 'Введите B: ',0h
msg2 db "Наибольшее число: ",0h
A dd '20'
C dd '50'

section .bss
max resb 10
B resb 10

section .text
global _start
_start:

; --- Вывод сообщения 'Введите B: '
mov eax,msg1
call sprint

; --- Ввод 'B'
mov ecx,B
mov edx,10
call sread

; --- Преобразование 'B' из символа в число
mov eax,B
call atoi
mov [B],eax

; --- Записываем 'A' в переменную 'max'
mov ecx,[A]
mov [max],ecx

; --- Сравниваем 'A' и 'C' (как символы)
cmp ecx,[C]
jg check_B
mov ecx,[C]
mov [max],ecx

; --- Преобразование 'max(A,C)' из символа в число
check_B:
mov eax,max
call atoi
mov [max],eax

; --- Сравниваем 'max(A,C)' и 'B' (как числа)
mov ecx,[max]
cmp ecx,[B]
jg fin
mov ecx,[B]
mov [max],ecx

; --- Вывод результата
fin:
mov eax, msg2
call sprint
mov eax,[max]
call iprintLF
call quit

Тестирование:

При B=30: Наибольшее число: 50

При B=60: Наибольшее число: 60

Анализ: Программа находит максимальное из трех чисел с использованием команд cmp и условных переходов.

3. Файл листинга (lab7-2.lst)
Анализ листинга: Файл показывает соответствие между исходным кодом и машинными командами, адресами памяти и байт-кодом.

4. Программа для нахождения минимума (minimum.asm)
Задание варианта 16: Найти минимальное из чисел: a=44, b=74, c=17

Код программы:

%include 'in_out.asm'

section .data
msg db "Наименьшее число: ",0
a dd 44
b dd 74
c dd 17

section .bss
min resb 10

section .text
global _start
_start:

; --- Записываем 'a' в переменную 'min'
mov ecx, [a]
mov [min], ecx

; --- Сравниваем 'a' и 'b'
cmp ecx, [b]
jl check_c    ; если a < b, переходим к сравнению с c
mov ecx, [b]    ; иначе min = b
mov [min], ecx

; --- Сравниваем текущий min с 'c'
check_c:
cmp ecx, [c]
jl print_result ; если min < c, переходим к выводу
mov ecx, [c]    ; иначе min = c
mov [min], ecx

; --- Вывод результата
print_result:
mov eax, msg
call sprint
mov eax, [min]
call iprintLF

call quit

Результат: Наименьшее число: 17

5. Программа с функцией f(x) (fonction_finale.asm)
Задание варианта 16:

f(x) = { x+4, если x < 4
       { a*x, если x ≥ 4

Код программы:
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

pop ebx ; ebx = a
pop eax ; eax = x

; --- Проверка условия
cmp eax, 4
jl cas_simple

; --- Случай x >= 4:
mov ecx, ebx ;
mov ebx, eax ;
mov eax, 0 ;
cmp ecx, 0
je affichage

multiplication:
add eax, ebx ;
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

Тестирование:
При x=3, a=5: Результат f(x): 7 (3 + 4 = 7)

Примечание: В режиме pipe наблюдается проблема с умножением, но в интерактивном режиме программа работает корректно.


Вывод
В ходе работы были изучены команды условных и безусловных переходов в ассемблере NASM. Были реализованы программы с использованием переходов для организации ветвлений и циклов. Особенности работы с умножением в ассемблере требуют дополнительного внимания к инициализации регистров.




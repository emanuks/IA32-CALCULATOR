%define SIZE_NAME 20
%define SIZE_OPTION_PRECISION 2
%define SIZE_NUMBERS_16 8
%define SIZE_NUMBERS_32 13

global _start
extern _print
extern _read_text
extern _read_number_32
extern _read_number_16
extern _soma_16
extern _subt_16
extern _mul_16
extern _div_16
extern _exp_16
extern _mod_16
extern _convert_to_string_16
extern _soma_32
extern _subt_32
extern _mul_32
extern _div_32
extern _exp_32
extern _mod_32
extern _convert_to_string_32

section .data
welcome_message db "Bem-vindo. Digite seu nome: ", 0
SIZE_WELCOME_MESSAGE EQU $-welcome_message
hola db "Hola, ", 0
SIZE_HOLA EQU $-hola
welcome_message_2 db ", bem-vindo ao programa de CALC IA-32", 0dh, 0ah
SIZE_WELCOME_MESSAGE_2 EQU $-welcome_message_2
precision_message db "Vai trabalhar com 16 ou 32 bits (digite 0 para 16 e 1 para 32) ", 0
SIZE_PRECISION_MESSAGE EQU $-precision_message
options_message db "ESCOLHA UMA OPCAO:", 0dh, 0ah, "- 1: SOMA", 0dh, 0ah, "- 2: SUBTRACAO", 0dh, 0ah, "- 3: MULTIPLICACAO", 0dh, 0ah, "- 4: DIVISAO", 0dh, 0ah, "- 5: EXPONENCIACAO", 0dh, 0ah, "- 6: MOD", 0dh, 0ah, "- 7: SAIR", 0dh, 0ah
SIZE_OPTIONS_MESSAGE EQU $-options_message
number1_message db "Insira o primeiro numero: ", 0
SIZE_NUMBER1_MESSAGE EQU $-number1_message
number2_message db "Insira o segundo numero: ", 0
SIZE_NUMBER2_MESSAGE EQU $-number2_message
result_message db "O resultado eh: ", 0
SIZE_RESULT_MESSAGE EQU $-result_message
newline db 0dh, 0ah
SIZE_NEWLINE EQU $-newline
overflow db "OCORREU OVERFLOW!", 0dh, 0ah
SIZE_OVERFLOW EQU $-overflow

message_1 db "PRECISAO 1", 0dh, 0ah
SIZE_message_1 EQU $-message_1
message_2 db "PRECISAO 2", 0dh, 0ah
SIZE_message_2 EQU $-message_2

section .bss
name resb 20
precision resb 1
option resb 1
number1_16_s resb 7
number2_16_s resb 7
number1_16 resw 1
number2_16 resw 1
result_16 resb 7
number1_32_s resb 12
number2_32_s resb 12
number1_32 resd 1
number2_32 resd 1
result_32 resb 12

section .text
_start:
    ;PRINT FIRST WELCOME MESSAGE
    PUSH DWORD SIZE_WELCOME_MESSAGE
    PUSH DWORD welcome_message
    call _print

    ;READ USER NAME
    PUSH DWORD SIZE_NAME
    PUSH DWORD name
    call _read_text

    ;PRINT HOLA
    PUSH DWORD SIZE_HOLA
    PUSH DWORD hola
    call _print

    ;PRINT USER NAME
    PUSH DWORD SIZE_NAME
    PUSH DWORD name
    call _print

    ;PRINT SECOND WELCOME MESSAGE
    PUSH DWORD SIZE_WELCOME_MESSAGE_2
    PUSH DWORD welcome_message_2
    call _print

    ;ASKS PRECISION
    PUSH DWORD SIZE_PRECISION_MESSAGE
    PUSH DWORD precision_message
    call _print

    ;READ PRECISION SELECTED
    PUSH DWORD SIZE_OPTION_PRECISION
    PUSH DWORD precision
    call _read_number_32
    MOV [precision], EAX

_menu:
    ;PRINT OPTIONS
    PUSH DWORD SIZE_OPTIONS_MESSAGE
    PUSH DWORD options_message
    call _print

    ;READ OPTION
    PUSH DWORD SIZE_OPTION_PRECISION
    PUSH DWORD option
    call _read_number_32
    MOV [option], EAX

_16_bits_operations:
    CMP BYTE [precision], 0
    JNE _32_bits_operations

    CMP BYTE [option], 7
    JE _exit

    PUSH DWORD SIZE_NUMBER1_MESSAGE
    PUSH DWORD number1_message
    call _print

    PUSH DWORD SIZE_NUMBERS_16
    PUSH DWORD number1_16_s
    call _read_number_16
    MOV [number1_16], AX

    PUSH DWORD SIZE_NUMBER2_MESSAGE
    PUSH DWORD number2_message
    call _print

    PUSH DWORD SIZE_NUMBERS_16
    PUSH DWORD number2_16_s
    call _read_number_16
    MOV [number2_16], AX

_sum_16:
    CMP BYTE [option], 1
    JNE _sub_16

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _soma_16
    PUSH AX

    JMP _print_result_16

_sub_16:
    CMP BYTE [option], 2
    JNE _mult_16

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _subt_16
    PUSH AX

    JMP _print_result_16

_mult_16:
    CMP BYTE [option], 3
    JNE _idiv_16

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _mul_16
    CMP EBX, 1
    JE _overflow
    PUSH AX

    JMP _print_result_16

_idiv_16:
    CMP BYTE [option], 4
    JNE _o_exp_16

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _div_16
    PUSH AX

    JMP _print_result_16
    
_o_exp_16:
    CMP BYTE [option], 5
    JNE _o_mod_16

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _exp_16
    CMP EBX, 1
    JE _overflow
    PUSH AX

    JMP _print_result_16

_o_mod_16:
    CMP BYTE [option], 6
    JNE _exit

    PUSH WORD [number1_16]
    PUSH WORD [number2_16]
    call _mod_16
    PUSH AX

    JMP _print_result_16

_print_result_16:
    PUSH DWORD SIZE_RESULT_MESSAGE
    PUSH DWORD result_message
    call _print

    POP AX
    PUSH result_16
    PUSH AX
    call _convert_to_string_16

    PUSH SIZE_NUMBERS_16
    PUSH result_16
    call _print

    PUSH SIZE_NEWLINE
    PUSH newline
    call _print

    JMP _menu

_32_bits_operations:
    CMP BYTE [option], 7
    JE _exit

    PUSH DWORD SIZE_NUMBER1_MESSAGE
    PUSH DWORD number1_message
    call _print

    PUSH DWORD SIZE_NUMBERS_32
    PUSH DWORD number1_32_s
    call _read_number_32
    MOV [number1_32], EAX

    PUSH DWORD SIZE_NUMBER2_MESSAGE
    PUSH DWORD number2_message
    call _print

    PUSH DWORD SIZE_NUMBERS_32
    PUSH DWORD number2_32_s
    call _read_number_32
    MOV [number2_32], EAX

_sum_32:
    CMP BYTE [option], 1
    JNE _sub_32

    PUSH DWORD [number1_32]
    PUSH DWORD [number2_32]
    call _soma_32
    PUSH EAX

    JMP _print_result_32

_sub_32:
    CMP BYTE [option], 2
    JNE _mult_32

    PUSH DWORD [number1_32]
    PUSH DWORD [number2_32]
    call _subt_32
    PUSH EAX

    JMP _print_result_32

_mult_32:
    CMP BYTE [option], 3
    JNE _idiv_32

    PUSH DWORD [number1_32]
    PUSH DWORD [number2_32]
    call _mul_32
    CMP EBX, 1
    JE _overflow
    PUSH EAX

    JMP _print_result_32

_idiv_32:
    CMP BYTE [option], 4
    JNE _o_exp_32

    PUSH DWORD [number1_32]
    PUSH DWORD [number2_32]
    call _div_32
    PUSH EAX

    JMP _print_result_32
    
_o_exp_32:
    CMP BYTE [option], 5
    JNE _o_mod_32

    PUSH WORD [number1_32]
    PUSH WORD [number2_32]
    call _exp_32
    CMP EBX, 1
    JE _overflow
    PUSH EAX

    JMP _print_result_32

_o_mod_32:
    CMP BYTE [option], 6
    JNE _exit

    PUSH DWORD [number1_32]
    PUSH DWORD [number2_32]
    call _mod_32
    PUSH EAX

    JMP _print_result_32

_print_result_32:
    PUSH DWORD SIZE_RESULT_MESSAGE
    PUSH DWORD result_message
    call _print

    POP EAX
    PUSH result_32
    PUSH EAX
    call _convert_to_string_32

    PUSH SIZE_NUMBERS_32
    PUSH result_32
    call _print

    PUSH SIZE_NEWLINE
    PUSH newline
    call _print

    JMP _menu

_overflow:
    PUSH SIZE_OVERFLOW
    PUSH overflow
    call _print

_exit:
    ;END PROGRAM
    MOV EAX, 1
    MOV EBX, 0
    INT 80h
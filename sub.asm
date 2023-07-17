global _subt_16
global _subt_32

section .text
_subt_16:
    PUSH EBP
    MOV EBP, ESP
    XOR EAX, EAX
    MOV AX, [EBP + 10]
    SUB AX, [EBP + 8]
    POP EBP
    RET 4

_subt_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, [EBP + 12]
    SUB EAX, [EBP + 8]
    POP EBP
    RET 8
    
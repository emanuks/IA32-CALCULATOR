global _div_16
global _div_32

section .text
_div_16:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV AX, [EBP + 10]
    MOV CX, [EBP + 8]
    CWD
    IDIV CX
    POP EBP
    RET 4

_div_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV EAX, [EBP + 12]
    MOV ECX, [EBP + 8]
    CDQ
    IDIV ECX
    POP EBP
    RET 8
    
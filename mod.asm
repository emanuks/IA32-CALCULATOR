global _mod_16
global _mod_32

section .text
_mod_16:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV AX, [EBP + 10]
    MOV CX, [EBP + 8]
    CWD
    IDIV CX
    MOV AX, DX
    POP EBP
    RET 4

_mod_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV EAX, [EBP + 12]
    MOV ECX, [EBP + 8]
    CDQ
    IDIV ECX
    MOV EAX, EDX
    POP EBP
    RET 8
    
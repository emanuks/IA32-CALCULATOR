global _mul_16
global _mul_32

section .text
_mul_16:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV AX, [EBP + 10]
    MOV CX, [EBP + 8]
    IMUL CX
    CMP DX, 0
    JE _ret_16
    CMP DX, 1111111111111111b
    JE _ret_16
    MOV EBX, 1
_ret_16:
    POP EBP
    RET 4

_mul_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV EAX, [EBP + 12]
    MOV ECX, [EBP + 8]
    IMUL ECX
    CMP EDX, 0
    JE _ret
    CMP EDX, 11111111111111111111111111111111b
    JE _ret
    MOV EBX, 1
_ret:
    POP EBP
    RET 8
    
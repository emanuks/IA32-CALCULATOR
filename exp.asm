global _exp_16
global _exp_32

section .text
_exp_16:
    PUSH EBP
    MOV EBP, ESP
    MOV ESI, 0
    MOV ECX, 0
    MOV BX, [EBP + 10]
    MOV AX, BX
    MOV CX, [EBP + 8]
    DEC CX
    JE _ret_16
_loop_16:
    IMUL BX
    CMP DX, 0
    JE _continue_16
    CMP DX, 1111111111111111b
    JE _continue_16
    MOV ESI, 1
    JMP _ret_16
_continue_16:
    MOV DX, 0
    loop _loop_16
_ret_16:
    MOV EBX, ESI
    POP EBP
    RET 4

_exp_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EBX, 0
    MOV EAX, [EBP + 12]
    MOV ECX, [EBP + 8]
    DEC ECX
    JE _ret
_loop:
    IMUL EAX
    CMP EDX, 0
    JE _continue
    CMP EDX, 1111111111111111b
    JE _continue
    MOV EBX, 1
    JMP _ret
_continue:
    MOV EDX, 0
    loop _loop
_ret:
    POP EBP
    RET 8
    
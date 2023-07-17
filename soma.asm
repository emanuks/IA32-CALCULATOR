global _soma_16
global _soma_32

section .text
_soma_16:
    PUSH EBP
    MOV EBP, ESP
    XOR EAX, EAX
    MOV AX, [EBP + 8]
    ADD AX, [EBP + 10]
    POP EBP
    RET 4

_soma_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, [EBP + 8]
    ADD EAX, [EBP + 12]
    POP EBP
    RET 8
    
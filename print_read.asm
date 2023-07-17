global _print
global _read_text
global _read_number_32
global _read_number_16
global _convert_to_string_16
global _convert_to_string_32

section .text
_print:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, 4
    MOV EBX, 1
    MOV ECX, [EBP + 8]
    MOV EDX, [EBP + 12]
    INT 80h
    POP EBP
    RET 8

_read_text:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, 3
    MOV EBX, 0
    MOV ECX, [EBP + 8]
    MOV EDX, [EBP + 12]
    INT 80h
    MOV BYTE [ECX + EAX - 1], 0
    POP EBP
    RET 8

_read_number_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, 3
    MOV EBX, 0
    MOV ECX, [EBP + 8]
    MOV EDX, [EBP + 12]
    INT 80h
    MOV EBX, 0
    XOR EAX, EAX
    MOVZX EDX, BYTE [ECX]
    CMP EDX, 2Dh
    JNE _atoi
    MOV EBX, 1
    INC ECX
_atoi:
    MOVZX EDX, BYTE [ECX]
    CMP EDX, 30h
    JB _is_negative
    CMP EDX, 39h
    JA _is_negative
    SUB EDX, 30h
    IMUL EAX, 10
    ADD EAX, EDX
    INC ECX
    JMP _atoi
_is_negative:
    CMP EBX, 1
    JNE _ret
    NEG EAX
_ret:
    POP EBP
    RET 8

_read_number_16:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, 3
    MOV EBX, 0
    MOV ECX, [EBP + 8]
    MOV EDX, [EBP + 12]
    INT 80h
    MOV EBX, 0
    XOR EAX, EAX
    XOR EDX, EDX
    MOVZX DX, BYTE [ECX]
    CMP DX, 2Dh
    JNE _atoi_16
    MOV EBX, 1
    INC ECX
_atoi_16:
    MOVZX DX, BYTE [ECX]
    CMP DX, 30h
    JB _is_negative_16
    CMP DX, 39h
    JA _is_negative_16
    SUB DX, 30h
    IMUL AX, 10
    ADD AX, DX
    INC ECX
    JMP _atoi_16
_is_negative_16:
    CMP EBX, 1
    JNE _ret_16
    NEG AX
_ret_16:
    POP EBP
    RET 8

_convert_to_string_16:
    PUSH EBP
    MOV EBP, ESP
    MOV AX, [EBP + 8]
    MOV ESI, 0
    MOV ECX, 0
    CMP AX, 8000h
    JB _skip_neg_16
    MOV ESI, 1
    NEG AX
_skip_neg_16:
    CWD
    MOV EBX, 10
    IDIV BX
    ADD DX, 30h
    INC ECX
    PUSH DX
    CMP AX, 0
    JG _skip_neg_16
    MOV EDX, 0
    CMP ESI, 1
    JNE _loop_16
    PUSH WORD 2Dh
    INC ECX
_loop_16:
    POP AX
    MOV ESI, [EBP + 10]
    MOV [ESI + EDX], AL
    INC EDX
    LOOP _loop_16
    MOV BYTE [ESI + EDX], 0dh
    INC EDX
    MOV BYTE [ESI + EDX], 0ah
    POP EBP
    RET 6

_convert_to_string_32:
    PUSH EBP
    MOV EBP, ESP
    MOV EAX, [EBP + 8]
    MOV EBX, 0
    MOV ECX, 0
    CMP EAX, 80000000h
    JB _skip_neg
    MOV EBX, 1
    NEG EAX
_skip_neg:
    CDQ
    MOV ESI, 10
    IDIV ESI
    ADD DX, 30h
    INC ECX
    PUSH DX
    CMP EAX, 0
    JG _skip_neg
    MOV EDX, 0
    CMP EBX, 1
    JNE _loop_32
    PUSH WORD 2Dh
    INC ECX
_loop_32:
    POP AX
    MOV ESI, [EBP + 12]
    MOV [ESI + EDX], AL
    INC EDX
    LOOP _loop_32
    MOV BYTE [ESI + EDX], 0dh
    INC EDX
    MOV BYTE [ESI + EDX], 0ah
    POP EBP
    RET 8

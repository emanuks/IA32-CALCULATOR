# CALCULATOR

## IA32 CALCULATOR

This program is a calculator with six different operations available in 16 bits and 32 bits modes.

The operations are:
 - ADD
 - SUB
 - MUL
 - DIV
 - EXP
 - MOD

All operations use signed operators.

### HOW TO RUN

```
nasm -f elf -o main.o main.asm
nasm -f elf -o print_read.o print_read.asm
nasm -f elf -o soma.o soma.asm
nasm -f elf -o sub.o sub.asm
nasm -f elf -o mul.o mul.asm
nasm -f elf -o div.o div.asm
nasm -f elf -o exp.o exp.asm
nasm -f elf -o mod.o mod.asm
ld -m elf_i386 -o main main.o soma.o print_read.o sub.o mul.o div.o exp.o mod.o
./main
```
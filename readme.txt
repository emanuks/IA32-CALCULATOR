ALUNO: EMANUEL SILVA DE MEDEIROS
MATRICULA: 170009360
SO: LINUX

COMO RODAR:
Primeiro compilar todos os arquivos com:
nasm -f elf -o main.o main.asm
nasm -f elf -o print_read.o print_read.asm
nasm -f elf -o soma.o soma.asm
nasm -f elf -o sub.o sub.asm
nasm -f elf -o mul.o mul.asm
nasm -f elf -o div.o div.asm
nasm -f elf -o exp.o exp.asm
nasm -f elf -o mod.o mod.asm
Apos isso eh necessario ligar os arquivos com:
ld -m elf_i386 -o main main.o soma.o print_read.o sub.o mul.o div.o exp.o mod.o
E logo apos executar com:
./main

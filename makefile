hexdumpv3: hexdumpv3.o
	ld -o hexdumpv3 hexdumpv3.o
hexdumpv3.o: hexdumpv3.asm
	nasm -f elf64 -g -F dwarf hexdumpv3.asm

AS=as
CC=gcc
LD=ld
as-option=--32 -g --gstabs -Wall
cc-option=-m32 -c -g -nostdlib -nostdinc -fno-stack-protector -Wall -fno-builtin -O0
ld-option=-m elf_i386 -nostdlib -Ttext 0x7c00

C_FILES=$(shell find -name "*.c")
S_FILES=$(shell find -name "*.s")
C_OBJECT=$(patsubst %.c, %.o, ${C_FILES})
S_OBJECT=$(patsubst %.s, %.o, ${S_FILES})


all: ${C_OBJECT} $(S_OBJECT) link cut update_image

.s.o:
	${AS} ${as-option} $< -o $@

.c.o:
	${CC} ${cc-option} $< -o $@

KERN_NAME=booter

link:
	${LD} ${ld-option} ${C_OBJECT} ${S_OBJECT} -o ${KERN_NAME}

cut:
	objcopy  ${KERN_NAME}  -O binary


.PHONY: update_image
update_image:
	dd if=./booter of=floppy.img bs=512 count=512


.PHONY:qemu
qemu:
	qemu-system-i386  -s -monitor stdio -fda floppy.img -boot a


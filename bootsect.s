
    .code16
    .align 0x4
    .text
    .global _start
_start:
    movb $0x03, %ah
    xor %bh, %bh
    int $0x10

    mov $0x13, %ah
    mov $0x01, %al
    mov $0x07, %bl
    mov $msg, %bp

    mov $12, %cx
    int $0x10
    hlt
msg:
.ascii "Hello World!"
.byte 0

    .org 512-2
    .word 0xaa55


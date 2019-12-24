.data
_prompt: .asciiz "Enter an interger:"
_ret: .asciiz "\n"
.globl main
.text
read:
li $v0, 4
la $a0, _prompt
syscall
li $v0, 5
syscall
jr $ra

write:
syscall
li $v0, 4
la $a0, _ret
syscall
move $v0, $0
jr $ra

main:
    li  $t0, 0
    li  $t1, 1
    li  $t2, 0
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal read
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    move $t3, $v0
    move  $t4, $t3
label0:
    blt $t2, $t4, label1
    j label2
label1:
    move  $t5, $t6
    move  $t0, $t1
    move  $t1, $t5
    move  $t2, $t7
    j label0
label2:

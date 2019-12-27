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
li $v0, 1
syscall
li $v0, 4
la $a0, _ret
syscall
move $v0, $0
jr $ra


main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 228
li  $t0, 0
li  $t1, 1
li  $t2, 0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t3, $v0
move $t4, $t3
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t3, 0($v0)
subu $v0, $fp, 28
sw $t4, 0($v0)
label0:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 28
lw $t1, 0($v0)
blt $t0, $t1, label1
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 12
lw $t1, 0($v0)
subu $v0, $fp, 16
lw $t2, 0($v0)
add $t0, $t1, $t2
move $t3, $t0
move $a0, $t2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t1, $t2
move $t2, $t3
subu $v0, $fp, 20
lw $t5, 0($v0)
addi $t4, $t5, 1
move $t5, $t4
subu $v0, $fp, 12
sw $t1, 0($v0)
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 20
sw $t5, 0($v0)
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 36
sw $t3, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
j label0
label2:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

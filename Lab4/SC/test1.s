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
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
subu $v1, $fp, 12
sw $t0 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
li $t2, 0
bgt $t1, $t2, label0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
j label1
label0:
li $a0, 1
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
j label2
label1:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 0
blt $t0, $t1, label3
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
j label4
label3:
li $t1, 0
addi $t0, $t1, -1
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 28
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label5
label4:
li $a0, 0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
label5:
label2:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

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


swap:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 96
move $t0, $a0
move $t1, $a1
move $t2, $t0
move $t0, $t1
move $t1, $t2
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
move $a0, $t1
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $t0
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 324
subu $sp, $sp, 80
move $t0, $sp
li  $t1, 0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
label0:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label1
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 16
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t5, $v0
sw $t5, 0($t3)
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 24
sw $t0 ,0($v1)
subu $v1, $fp, 28
sw $t2 ,0($v1)
subu $v1, $fp, 32
sw $t3 ,0($v1)
subu $v1, $fp, 36
sw $t5 ,0($v1)
li $t6, 0
bgt $t1, $t6, label3
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 28
sw $t2, 0($v0)
subu $v0, $fp, 32
sw $t3, 0($v0)
subu $v0, $fp, 36
sw $t5, 0($v0)
subu $v0, $fp, 40
sw $t6, 0($v0)
j label4
label3:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, -1
li $t3, 4
mul $t2, $t3, $t0
subu $v0, $fp, 12
lw $t5, 0($v0)
add $t4, $t5, $t2
li $t7, 4
mul $t6, $t7, $t1
add $t8, $t5, $t6
subu $v1, $fp, 12
sw $t5 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 44
sw $t0 ,0($v1)
subu $v1, $fp, 48
sw $t2 ,0($v1)
subu $v1, $fp, 52
sw $t3 ,0($v1)
subu $v1, $fp, 56
sw $t4 ,0($v1)
subu $v1, $fp, 60
sw $t6 ,0($v1)
subu $v1, $fp, 64
sw $t7 ,0($v1)
subu $v1, $fp, 68
sw $t8 ,0($v1)
lw $t9, 0($t4)
move $a0, $t9
lw $s0, 0($t8)
move $a1, $s0
jal swap
move $t0, $v0
subu $v0, $fp, 80
sw $t0, 0($v0)
label4:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 84
sw $t0, 0($v0)
j label0
label2:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

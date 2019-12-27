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
subu $sp, $sp, 432
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t2, $v0
move $t3, $t2
li $t5, 2
div $t3, $t5
mflo $t4
li $t7, 2
mul $t6, $t4, $t7
subu $v1, $fp, 12
sw $t0 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 20
sw $t2 ,0($v1)
subu $v1, $fp, 24
sw $t3 ,0($v1)
subu $v1, $fp, 28
sw $t4 ,0($v1)
subu $v1, $fp, 32
sw $t5 ,0($v1)
subu $v1, $fp, 36
sw $t6 ,0($v1)
subu $v1, $fp, 40
sw $t7 ,0($v1)
beq $t3, $t6, label0
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
subu $v0, $fp, 32
sw $t5, 0($v0)
subu $v0, $fp, 36
sw $t6, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
j label1
label0:
li  $t0, 1
subu $v0, $fp, 44
sw $t0, 0($v0)
j label2
label1:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
move $t0, $t1
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 44
sw $t0, 0($v0)
label2:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 2
div $t1, $t2
mflo $t0
move $t1, $t0
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 48
sw $t0, 0($v0)
subu $v0, $fp, 52
sw $t2, 0($v0)
label3:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 0
bgt $t0, $t1, label4
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 56
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 16
lw $t1, 0($v0)
mul $t0, $t1, $t1
move $t1, $t0
subu $v0, $fp, 24
lw $t3, 0($v0)
li $t4, 2
div $t3, $t4
mflo $t2
li $t6, 2
mul $t5, $t2, $t6
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 24
sw $t3 ,0($v1)
subu $v1, $fp, 60
sw $t0 ,0($v1)
subu $v1, $fp, 64
sw $t2 ,0($v1)
subu $v1, $fp, 68
sw $t4 ,0($v1)
subu $v1, $fp, 72
sw $t5 ,0($v1)
subu $v1, $fp, 76
sw $t6 ,0($v1)
bne $t3, $t5, label6
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 24
sw $t3, 0($v0)
subu $v0, $fp, 60
sw $t0, 0($v0)
subu $v0, $fp, 64
sw $t2, 0($v0)
subu $v0, $fp, 68
sw $t4, 0($v0)
subu $v0, $fp, 72
sw $t5, 0($v0)
subu $v0, $fp, 76
sw $t6, 0($v0)
j label7
label6:
subu $v0, $fp, 44
lw $t1, 0($v0)
subu $v0, $fp, 16
lw $t2, 0($v0)
mul $t0, $t1, $t2
move $t1, $t0
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 44
sw $t1, 0($v0)
subu $v0, $fp, 80
sw $t0, 0($v0)
label7:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 2
div $t1, $t2
mflo $t0
move $t1, $t0
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 84
sw $t0, 0($v0)
subu $v0, $fp, 88
sw $t2, 0($v0)
j label3
label5:
subu $v0, $fp, 44
lw $t0, 0($v0)
move $a0, $t0
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
li $v0, 0
jr $ra

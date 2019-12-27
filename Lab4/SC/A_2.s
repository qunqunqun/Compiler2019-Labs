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
subu $sp, $sp, 624
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
subu $v1, $fp, 12
sw $t0 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 20
sw $t2 ,0($v1)
subu $v1, $fp, 24
sw $t3 ,0($v1)
li $t4, 100
bgt $t1, $t4, label0
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
j label1
label0:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 50
blt $t0, $t1, label3
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label4
label3:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 16
lw $t2, 0($v0)
add $t0, $t1, $t2
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t0, 0($v0)
j label5
label4:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 16
lw $t2, 0($v0)
sub $t0, $t1, $t2
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t0, 0($v0)
label5:
j label2
label1:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 100
beq $t0, $t1, label6
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 44
sw $t1, 0($v0)
j label7
label6:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 100
blt $t0, $t1, label9
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label10
label9:
subu $v0, $fp, 24
lw $t0, 0($v0)
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 24
sw $t0, 0($v0)
j label11
label10:
subu $v0, $fp, 24
lw $t1, 0($v0)
addi $t0, $t1, -100
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 52
sw $t0, 0($v0)
label11:
j label8
label7:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 100
blt $t0, $t1, label12
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 56
sw $t1, 0($v0)
j label13
label12:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 16
lw $t2, 0($v0)
add $t0, $t1, $t2
subu $v1, $fp, 16
sw $t2 ,0($v1)
subu $v1, $fp, 24
sw $t1 ,0($v1)
subu $v1, $fp, 60
sw $t0 ,0($v1)
li $t3, 100
bgt $t0, $t3, label14
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 60
sw $t0, 0($v0)
subu $v0, $fp, 64
sw $t3, 0($v0)
j label15
label14:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, 100
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 68
sw $t0, 0($v0)
j label16
label15:
li $a0, 100
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
label16:
label13:
label8:
label2:
subu $v0, $fp, 16
lw $t1, 0($v0)
subu $v0, $fp, 24
lw $t2, 0($v0)
add $t0, $t1, $t2
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

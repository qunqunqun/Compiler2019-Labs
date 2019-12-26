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


fact:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 156
move $t0, $a0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 12
lw $t0, 0($v0)
beq $t0 1 label0
subu $v0, $fp, 12
sw $t0, 0($v0)
j label1
label0:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 12
lw $t0, 0($v0)
move $v0, $t0
jr $ra
subu $v0, $fp, 12
sw $t0, 0($v0)
j label2
label1:
subu $v0, $fp, 12
lw $t1, 0($v0)
addi $t0, $t1, -1
move $a0, $t0
subu $v0, $fp, 12
sw $t1, 0($v0)
subu $v0, $fp, 16
sw $t0, 0($v0)
jal fact
move $t0, $v0
subu $v0, $fp, 12
lw $t2, 0($v0)
mul $t1, $t2, $t0
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $t1
jr $ra
subu $v0, $fp, 12
sw $t2, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
label2:

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 168
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 16
lw $t0, 0($v0)
bgt $t0 1 label3
subu $v0, $fp, 16
sw $t0, 0($v0)
j label4
label3:
subu $v0, $fp, 16
lw $t0, 0($v0)
move $a0, $t0
subu $v0, $fp, 16
sw $t0, 0($v0)
jal fact
move $t0, $v0
move $t1, $t0
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 24
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 24
sw $t0, 0($v0)
label5:
subu $v0, $fp, 24
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

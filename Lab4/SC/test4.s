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


fadd:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 84
move $t0, $a0
li $t2, 4
li $t3, 0
mul $t1, $t2, $t3
move $t5, $t0
add $t4, $t5, $t1
li $t7, 4
li $t8, 1
mul $t6, $t7, $t8
move $s0, $t0
add $t9, $s0, $t6
lw $s2, 0($t4)
lw $s3, 0($t9)
add $s1, $s2, $s3
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $s1
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 456
subu $sp, $sp, 32
move $t0, $sp
subu $sp, $sp, 32
move $t1, $sp
li  $t2, 0
li  $t3, 0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t3, 0($v0)
label0:
subu $v0, $fp, 20
lw $t0, 0($v0)
li $t1, 2
blt $t0, $t1, label1
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
j label2
label1:
label3:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 2
blt $t0, $t1, label4
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 20
lw $t6, 0($v0)
add $t5, $t6, $t1
sw $t5, 0($t3)
addi $t7, $t1, 1
move $t1, $t7
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 20
sw $t6, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t0, 0($v0)
subu $v0, $fp, 40
sw $t2, 0($v0)
subu $v0, $fp, 44
sw $t3, 0($v0)
subu $v0, $fp, 48
sw $t5, 0($v0)
subu $v0, $fp, 52
sw $t7, 0($v0)
j label3
label5:
li $t1, 8
li $t2, 0
mul $t0, $t1, $t2
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 20
lw $t6, 0($v0)
li $t7, 4
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
subu $v1, $fp, 16
sw $t4 ,0($v1)
subu $v1, $fp, 20
sw $t6 ,0($v1)
subu $v1, $fp, 56
sw $t0 ,0($v1)
subu $v1, $fp, 60
sw $t1 ,0($v1)
subu $v1, $fp, 64
sw $t2 ,0($v1)
subu $v1, $fp, 68
sw $t3 ,0($v1)
subu $v1, $fp, 72
sw $t5 ,0($v1)
subu $v1, $fp, 76
sw $t7 ,0($v1)
subu $v1, $fp, 80
sw $t8 ,0($v1)
subu $v1, $fp, 84
sw $t9 ,0($v1)
subu $v0, $fp, 12
lw $s0, 0($v0)
move $a0, $s0
jal fadd
move $t0, $v0
subu $v0, $fp, 80
lw $t1, 0($v0)
sw $t0, 0($t1)
li $t3, 8
li $t4, 0
mul $t2, $t3, $t4
subu $v0, $fp, 16
lw $t6, 0($v0)
add $t5, $t6, $t2
subu $v0, $fp, 20
lw $t8, 0($v0)
li $t9, 4
mul $t7, $t9, $t8
move $s1, $t5
add $s0, $s1, $t7
lw $s2, 0($s0)
move $a0, $s2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
addi $s3, $t8, 1
move $t8, $s3
subu $v0, $fp, 24
lw $s4, 0($v0)
li  $s4, 0
subu $v0, $fp, 16
sw $t6, 0($v0)
subu $v0, $fp, 20
sw $t8, 0($v0)
subu $v0, $fp, 24
sw $s4, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 88
sw $t0, 0($v0)
subu $v0, $fp, 92
sw $t2, 0($v0)
subu $v0, $fp, 96
sw $t3, 0($v0)
subu $v0, $fp, 100
sw $t4, 0($v0)
subu $v0, $fp, 104
sw $t5, 0($v0)
subu $v0, $fp, 108
sw $t7, 0($v0)
subu $v0, $fp, 112
sw $t9, 0($v0)
subu $v0, $fp, 116
sw $s0, 0($v0)
subu $v0, $fp, 120
sw $s1, 0($v0)
subu $v0, $fp, 124
sw $s2, 0($v0)
subu $v0, $fp, 128
sw $s3, 0($v0)
j label0
label2:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

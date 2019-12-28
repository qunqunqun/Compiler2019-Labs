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
subu $sp, $sp, 792
subu $sp, $sp, 20
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
addi $t6, $t1, 1
move $t1, $t6
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
j label0
label2:
subu $v0, $fp, 16
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 16
sw $t0, 0($v0)
label3:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label4
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 44
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 16
lw $t1, 0($v0)
move $t0, $t1
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 48
sw $t0, 0($v0)
label6:
subu $v0, $fp, 48
lw $t0, 0($v0)
li $t1, 0
bgt $t0, $t1, label9
subu $v0, $fp, 48
sw $t0, 0($v0)
subu $v0, $fp, 52
sw $t1, 0($v0)
j label8
label9:
subu $v0, $fp, 48
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
subu $v1, $fp, 48
sw $t1 ,0($v1)
subu $v1, $fp, 56
sw $t0 ,0($v1)
subu $v1, $fp, 60
sw $t2 ,0($v1)
subu $v1, $fp, 64
sw $t3 ,0($v1)
subu $v1, $fp, 68
sw $t4 ,0($v1)
subu $v1, $fp, 72
sw $t6 ,0($v1)
subu $v1, $fp, 76
sw $t7 ,0($v1)
subu $v1, $fp, 80
sw $t8 ,0($v1)
lw $t9, 0($t4)
lw $s0, 0($t8)
bgt $t9, $s0, label7
subu $v0, $fp, 12
sw $t5, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 56
sw $t0, 0($v0)
subu $v0, $fp, 60
sw $t2, 0($v0)
subu $v0, $fp, 64
sw $t3, 0($v0)
subu $v0, $fp, 68
sw $t4, 0($v0)
subu $v0, $fp, 72
sw $t6, 0($v0)
subu $v0, $fp, 76
sw $t7, 0($v0)
subu $v0, $fp, 80
sw $t8, 0($v0)
subu $v0, $fp, 84
sw $t9, 0($v0)
subu $v0, $fp, 88
sw $s0, 0($v0)
j label8
label7:
subu $v0, $fp, 48
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw  $t5, 0($t3)
li $t7, 4
mul $t6, $t7, $t1
add $t8, $t4, $t6
addi $t9, $t1, -1
li $s1, 4
mul $s0, $s1, $t9
add $s2, $t4, $s0
lw $s3, 0($s2)
sw $s3, 0($t8)
addi $s4, $t1, -1
li $s6, 4
mul $s5, $s6, $s4
add $s7, $t4, $s5
sw $t5, 0($s7)
subu $v0, $fp, 96
sw $t2, 0($v0)
addi $t2, $t1, -1
move $t1, $t2
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 92
sw $t0, 0($v0)
subu $v0, $fp, 100
sw $t3, 0($v0)
subu $v0, $fp, 104
sw $t5, 0($v0)
subu $v0, $fp, 108
sw $t6, 0($v0)
subu $v0, $fp, 112
sw $t7, 0($v0)
subu $v0, $fp, 116
sw $t8, 0($v0)
subu $v0, $fp, 120
sw $t9, 0($v0)
subu $v0, $fp, 124
sw $s0, 0($v0)
subu $v0, $fp, 128
sw $s1, 0($v0)
subu $v0, $fp, 132
sw $s2, 0($v0)
subu $v0, $fp, 136
sw $s3, 0($v0)
subu $v0, $fp, 140
sw $s4, 0($v0)
subu $v0, $fp, 144
sw $s5, 0($v0)
subu $v0, $fp, 148
sw $s6, 0($v0)
subu $v0, $fp, 152
sw $s7, 0($v0)
subu $v0, $fp, 156
sw $t2, 0($v0)
j label6
label8:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 160
sw $t0, 0($v0)
j label3
label5:
subu $v0, $fp, 16
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 16
sw $t0, 0($v0)
label10:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label11
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 164
sw $t1, 0($v0)
j label12
label11:
subu $v0, $fp, 16
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t5, 0($t3)
move $a0, $t5
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
addi $t6, $t1, 1
move $t1, $t6
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 168
sw $t0, 0($v0)
subu $v0, $fp, 172
sw $t2, 0($v0)
subu $v0, $fp, 176
sw $t3, 0($v0)
subu $v0, $fp, 180
sw $t5, 0($v0)
subu $v0, $fp, 184
sw $t6, 0($v0)
j label10
label12:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

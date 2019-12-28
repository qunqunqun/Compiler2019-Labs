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
subu $sp, $sp, 732
subu $sp, $sp, 80
move $t0, $sp
li  $t1, 10
li  $t2, 0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
label0:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label1
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label2
label1:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 8
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
move $t6, $t3
addi $t5, $t6, 0
li $t7, 10
sw $t7, 0($t5)
li $t9, 8
mul $t8, $t9, $t1
add $s0, $t4, $t8
move $s2, $s0
addi $s1, $s2, 4
sw $t1, 0($s1)
addi $s3, $t1, 1
move $t1, $s3
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 20
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
subu $v0, $fp, 44
sw $t7, 0($v0)
subu $v0, $fp, 48
sw $t8, 0($v0)
subu $v0, $fp, 52
sw $t9, 0($v0)
subu $v0, $fp, 56
sw $s0, 0($v0)
subu $v0, $fp, 60
sw $s1, 0($v0)
subu $v0, $fp, 64
sw $s2, 0($v0)
subu $v0, $fp, 68
sw $s3, 0($v0)
j label0
label2:
subu $v0, $fp, 20
lw $t0, 0($v0)
li  $t0, 0
li  $t1, 0
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 72
sw $t1, 0($v0)
label3:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label4
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label5
label4:
li  $t0, 0
subu $v0, $fp, 20
lw $t2, 0($v0)
li $t3, 8
mul $t1, $t3, $t2
subu $v0, $fp, 12
lw $t5, 0($v0)
add $t4, $t5, $t1
move $t7, $t4
addi $t6, $t7, 4
subu $v0, $fp, 72
lw $t9, 0($v0)
lw $s0, 0($t6)
add $t8, $t9, $s0
move $t9, $t8
subu $v0, $fp, 12
sw $t5, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
subu $v0, $fp, 72
sw $t9, 0($v0)
subu $v0, $fp, 76
sw $t0, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 84
sw $t3, 0($v0)
subu $v0, $fp, 88
sw $t4, 0($v0)
subu $v0, $fp, 92
sw $t6, 0($v0)
subu $v0, $fp, 96
sw $t7, 0($v0)
subu $v0, $fp, 100
sw $t8, 0($v0)
subu $v0, $fp, 104
sw $s0, 0($v0)
label6:
subu $v0, $fp, 76
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label7
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 76
sw $t0, 0($v0)
j label8
label7:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 8
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
move $t6, $t3
addi $t5, $t6, 0
li $t8, 8
mul $t7, $t8, $t1
add $t9, $t4, $t7
move $s1, $t9
addi $s0, $s1, 0
subu $v0, $fp, 76
lw $s3, 0($v0)
li $s4, 8
mul $s2, $s4, $s3
add $s5, $t4, $s2
move $s7, $s5
addi $s6, $s7, 4
subu $v0, $fp, 112
sw $t2, 0($v0)
subu $v0, $fp, 108
sw $t0, 0($v0)
subu $v0, $fp, 72
lw $t0, 0($v0)
subu $v0, $fp, 116
sw $t3, 0($v0)
lw $t3, 0($s6)
mul $t2, $t0, $t3
subu $v0, $fp, 120
sw $t5, 0($v0)
subu $v0, $fp, 124
sw $t6, 0($v0)
lw $t6, 0($s0)
add $t5, $t6, $t2
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 120
lw $t1, 0($v0)
sw $t5, 0($t1)
subu $v0, $fp, 132
sw $t8, 0($v0)
addi $t8, $s3, 1
move $s3, $t8
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 72
sw $t0, 0($v0)
subu $v0, $fp, 76
sw $s3, 0($v0)
subu $v0, $fp, 120
sw $t1, 0($v0)
subu $v0, $fp, 128
sw $t7, 0($v0)
subu $v0, $fp, 136
sw $t9, 0($v0)
subu $v0, $fp, 140
sw $s0, 0($v0)
subu $v0, $fp, 144
sw $s1, 0($v0)
subu $v0, $fp, 148
sw $s2, 0($v0)
subu $v0, $fp, 152
sw $s4, 0($v0)
subu $v0, $fp, 156
sw $s5, 0($v0)
subu $v0, $fp, 160
sw $s6, 0($v0)
subu $v0, $fp, 164
sw $s7, 0($v0)
subu $v0, $fp, 168
sw $t2, 0($v0)
subu $v0, $fp, 172
sw $t3, 0($v0)
subu $v0, $fp, 176
sw $t5, 0($v0)
subu $v0, $fp, 180
sw $t6, 0($v0)
subu $v0, $fp, 184
sw $t8, 0($v0)
j label6
label8:
subu $v0, $fp, 20
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 188
sw $t0, 0($v0)
j label3
label5:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, -1
li $t3, 8
mul $t2, $t3, $t0
subu $v0, $fp, 12
lw $t5, 0($v0)
add $t4, $t5, $t2
move $t7, $t4
addi $t6, $t7, 0
lw $t8, 0($t6)
move $a0, $t8
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

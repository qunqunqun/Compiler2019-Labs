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


qsort:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 960
move $t0, $a0
move $t1, $a1
move $t2, $a2
li $t4, 4
mul $t3, $t4, $t1
move $t6, $t0
add $t5, $t6, $t3
lw  $t7, 0($t5)
move $t8, $t1
move $t9, $t2
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
subu $v1, $fp, 44
sw $t8 ,0($v1)
subu $v1, $fp, 48
sw $t9 ,0($v1)
blt $t8, $t9, label0
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
subu $v0, $fp, 44
sw $t8, 0($v0)
subu $v0, $fp, 48
sw $t9, 0($v0)
j label1
label0:
label2:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 48
lw $t1, 0($v0)
blt $t0, $t1, label3
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label4
label3:
label5:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 48
lw $t1, 0($v0)
blt $t0, $t1, label8
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label7
label8:
subu $v0, $fp, 48
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 48
sw $t1 ,0($v1)
subu $v1, $fp, 52
sw $t0 ,0($v1)
subu $v1, $fp, 56
sw $t2 ,0($v1)
subu $v1, $fp, 60
sw $t3 ,0($v1)
subu $v1, $fp, 64
sw $t5 ,0($v1)
lw $t6, 0($t3)
subu $v0, $fp, 40
lw $t7, 0($v0)
bgt $t6, $t7, label6
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 52
sw $t0, 0($v0)
subu $v0, $fp, 56
sw $t2, 0($v0)
subu $v0, $fp, 60
sw $t3, 0($v0)
subu $v0, $fp, 64
sw $t5, 0($v0)
subu $v0, $fp, 68
sw $t6, 0($v0)
j label7
label6:
subu $v0, $fp, 48
lw $t1, 0($v0)
addi $t0, $t1, -1
move $t1, $t0
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 72
sw $t0, 0($v0)
j label5
label7:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 48
lw $t1, 0($v0)
blt $t0, $t1, label9
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label10
label9:
subu $v0, $fp, 44
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v0, $fp, 48
lw $t7, 0($v0)
li $t8, 4
mul $t6, $t8, $t7
move $s0, $t4
add $t9, $s0, $t6
lw $s1, 0($t9)
sw $s1, 0($t3)
addi $s2, $t1, 1
move $t1, $s2
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 44
sw $t1, 0($v0)
subu $v0, $fp, 48
sw $t7, 0($v0)
subu $v0, $fp, 76
sw $t0, 0($v0)
subu $v0, $fp, 80
sw $t2, 0($v0)
subu $v0, $fp, 84
sw $t3, 0($v0)
subu $v0, $fp, 88
sw $t5, 0($v0)
subu $v0, $fp, 92
sw $t6, 0($v0)
subu $v0, $fp, 96
sw $t8, 0($v0)
subu $v0, $fp, 100
sw $t9, 0($v0)
subu $v0, $fp, 104
sw $s0, 0($v0)
subu $v0, $fp, 108
sw $s1, 0($v0)
subu $v0, $fp, 112
sw $s2, 0($v0)
label10:
label11:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 48
lw $t1, 0($v0)
blt $t0, $t1, label14
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label13
label14:
subu $v0, $fp, 44
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 44
sw $t1 ,0($v1)
subu $v1, $fp, 116
sw $t0 ,0($v1)
subu $v1, $fp, 120
sw $t2 ,0($v1)
subu $v1, $fp, 124
sw $t3 ,0($v1)
subu $v1, $fp, 128
sw $t5 ,0($v1)
lw $t6, 0($t3)
subu $v0, $fp, 40
lw $t7, 0($v0)
blt $t6, $t7, label12
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
subu $v0, $fp, 44
sw $t1, 0($v0)
subu $v0, $fp, 116
sw $t0, 0($v0)
subu $v0, $fp, 120
sw $t2, 0($v0)
subu $v0, $fp, 124
sw $t3, 0($v0)
subu $v0, $fp, 128
sw $t5, 0($v0)
subu $v0, $fp, 132
sw $t6, 0($v0)
j label13
label12:
subu $v0, $fp, 44
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 44
sw $t1, 0($v0)
subu $v0, $fp, 136
sw $t0, 0($v0)
j label11
label13:
subu $v0, $fp, 44
lw $t0, 0($v0)
subu $v0, $fp, 48
lw $t1, 0($v0)
blt $t0, $t1, label15
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label16
label15:
subu $v0, $fp, 48
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v0, $fp, 44
lw $t7, 0($v0)
li $t8, 4
mul $t6, $t8, $t7
move $s0, $t4
add $t9, $s0, $t6
lw $s1, 0($t9)
sw $s1, 0($t3)
addi $s2, $t1, -1
move $t1, $s2
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 44
sw $t7, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 140
sw $t0, 0($v0)
subu $v0, $fp, 144
sw $t2, 0($v0)
subu $v0, $fp, 148
sw $t3, 0($v0)
subu $v0, $fp, 152
sw $t5, 0($v0)
subu $v0, $fp, 156
sw $t6, 0($v0)
subu $v0, $fp, 160
sw $t8, 0($v0)
subu $v0, $fp, 164
sw $t9, 0($v0)
subu $v0, $fp, 168
sw $s0, 0($v0)
subu $v0, $fp, 172
sw $s1, 0($v0)
subu $v0, $fp, 176
sw $s2, 0($v0)
label16:
j label2
label4:
subu $v0, $fp, 44
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v0, $fp, 40
lw $t6, 0($v0)
sw $t6, 0($t3)
addi $t7, $t1, -1
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 40
sw $t6 ,0($v1)
subu $v1, $fp, 44
sw $t1 ,0($v1)
subu $v1, $fp, 180
sw $t0 ,0($v1)
subu $v1, $fp, 184
sw $t2 ,0($v1)
subu $v1, $fp, 188
sw $t3 ,0($v1)
subu $v1, $fp, 192
sw $t5 ,0($v1)
subu $v1, $fp, 196
sw $t7 ,0($v1)
move $t8, $t4
move $a0, $t8
subu $v0, $fp, 16
lw $t9, 0($v0)
move $a1, $t9
move $a2, $t7
jal qsort
move $t0, $v0
subu $v0, $fp, 44
lw $t2, 0($v0)
addi $t1, $t2, 1
subu $v1, $fp, 44
sw $t2 ,0($v1)
subu $v1, $fp, 204
sw $t0 ,0($v1)
subu $v1, $fp, 208
sw $t1 ,0($v1)
subu $v0, $fp, 12
lw $t3, 0($v0)
move $t4, $t3
move $a0, $t4
move $a1, $t1
subu $v0, $fp, 20
lw $t5, 0($v0)
move $a2, $t5
jal qsort
move $t0, $v0
subu $v0, $fp, 216
sw $t0, 0($v0)
label1:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 396
subu $sp, $sp, 40
move $t0, $sp
li  $t1, 10
li  $t2, 0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
label17:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label18
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label19
label18:
subu $v0, $fp, 20
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
j label17
label19:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 44
sw $t0 ,0($v1)
subu $v0, $fp, 12
lw $t2, 0($v0)
move $a0, $t2
li $t3, 0
move $a1, $t3
move $a2, $t0
jal qsort
move $t0, $v0
subu $v0, $fp, 20
lw $t1, 0($v0)
li  $t1, 0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 52
sw $t0, 0($v0)
label20:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label21
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label22
label21:
subu $v0, $fp, 20
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
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 56
sw $t0, 0($v0)
subu $v0, $fp, 60
sw $t2, 0($v0)
subu $v0, $fp, 64
sw $t3, 0($v0)
subu $v0, $fp, 68
sw $t5, 0($v0)
subu $v0, $fp, 72
sw $t6, 0($v0)
j label20
label22:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

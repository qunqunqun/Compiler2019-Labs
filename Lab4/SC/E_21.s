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
subu $sp, $sp, 1224
subu $sp, $sp, 2400
move $t0, $sp
li  $t1, 10
li  $t2, 5
li  $t3, 3
li  $t4, 0
li  $t5, 0
li  $t6, 0
li  $t7, 0
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
label0:
subu $v0, $fp, 28
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label1
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t0, 0($v0)
j label2
label1:
subu $v0, $fp, 32
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 32
sw $t0, 0($v0)
label3:
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 20
lw $t1, 0($v0)
blt $t0, $t1, label4
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t0, 0($v0)
j label5
label4:
subu $v0, $fp, 36
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 36
sw $t0, 0($v0)
label6:
subu $v0, $fp, 36
lw $t0, 0($v0)
subu $v0, $fp, 24
lw $t1, 0($v0)
blt $t0, $t1, label7
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t0, 0($v0)
j label8
label7:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 60
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 32
lw $t6, 0($v0)
li $t7, 12
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
subu $v0, $fp, 36
lw $s1, 0($v0)
li $s2, 4
mul $s0, $s2, $s1
move $s4, $t8
add $s3, $s4, $s0
subu $v0, $fp, 16
lw $s6, 0($v0)
mul $s5, $t1, $s6
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 20
lw $t2, 0($v0)
mul $s7, $t6, $t2
subu $v0, $fp, 44
sw $t0, 0($v0)
add $t0, $s5, $s7
subu $v0, $fp, 12
sw $t4, 0($v0)
addi $t4, $s1, 1
subu $v0, $fp, 60
sw $t7, 0($v0)
subu $v0, $fp, 52
sw $t3, 0($v0)
subu $v0, $fp, 24
lw $t3, 0($v0)
div $t3, $t4
mflo $t7
subu $v0, $fp, 56
sw $t5, 0($v0)
add $t5, $t0, $t7
sw $t5, 0($s3)
subu $v0, $fp, 68
sw $t9, 0($v0)
addi $t9, $s1, 1
move $s1, $t9
subu $v0, $fp, 16
sw $s6, 0($v0)
subu $v0, $fp, 20
sw $t2, 0($v0)
subu $v0, $fp, 24
sw $t3, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t6, 0($v0)
subu $v0, $fp, 36
sw $s1, 0($v0)
subu $v0, $fp, 64
sw $t8, 0($v0)
subu $v0, $fp, 72
sw $s0, 0($v0)
subu $v0, $fp, 76
sw $s2, 0($v0)
subu $v0, $fp, 80
sw $s3, 0($v0)
subu $v0, $fp, 84
sw $s4, 0($v0)
subu $v0, $fp, 88
sw $s5, 0($v0)
subu $v0, $fp, 92
sw $s7, 0($v0)
subu $v0, $fp, 96
sw $t0, 0($v0)
subu $v0, $fp, 100
sw $t4, 0($v0)
subu $v0, $fp, 104
sw $t7, 0($v0)
subu $v0, $fp, 108
sw $t5, 0($v0)
subu $v0, $fp, 112
sw $t9, 0($v0)
j label6
label8:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 116
sw $t0, 0($v0)
j label3
label5:
subu $v0, $fp, 28
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 120
sw $t0, 0($v0)
j label0
label2:
subu $v0, $fp, 28
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 32
lw $t1, 0($v0)
li  $t1, 0
subu $v0, $fp, 36
lw $t2, 0($v0)
li  $t2, 0
subu $v0, $fp, 28
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t2, 0($v0)
label9:
subu $v0, $fp, 28
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
blt $t0, $t1, label10
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t0, 0($v0)
j label11
label10:
subu $v0, $fp, 32
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 32
sw $t0, 0($v0)
label12:
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 20
lw $t1, 0($v0)
blt $t0, $t1, label13
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t0, 0($v0)
j label14
label13:
subu $v0, $fp, 36
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 36
sw $t0, 0($v0)
label15:
subu $v0, $fp, 36
lw $t0, 0($v0)
subu $v0, $fp, 24
lw $t1, 0($v0)
blt $t0, $t1, label16
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t0, 0($v0)
j label17
label16:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 60
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 32
lw $t6, 0($v0)
li $t7, 12
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
subu $v0, $fp, 36
lw $s1, 0($v0)
li $s2, 4
mul $s0, $s2, $s1
move $s4, $t8
add $s3, $s4, $s0
li $s6, 60
li $s7, 0
mul $s5, $s6, $s7
subu $v0, $fp, 28
sw $t1, 0($v0)
add $t1, $t4, $s5
subu $v0, $fp, 128
sw $t2, 0($v0)
subu $v0, $fp, 124
sw $t0, 0($v0)
li $t0, 12
subu $v0, $fp, 32
sw $t6, 0($v0)
li $t6, 0
mul $t2, $t0, $t6
subu $v0, $fp, 140
sw $t7, 0($v0)
subu $v0, $fp, 132
sw $t3, 0($v0)
move $t3, $t1
add $t7, $t3, $t2
subu $v0, $fp, 136
sw $t5, 0($v0)
subu $v0, $fp, 148
sw $t9, 0($v0)
li $t9, 4
subu $v0, $fp, 36
sw $s1, 0($v0)
li $s1, 0
mul $t5, $t9, $s1
subu $v0, $fp, 156
sw $s2, 0($v0)
subu $v0, $fp, 144
sw $t8, 0($v0)
move $t8, $t7
add $s2, $t8, $t5
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 152
sw $s0 ,0($v1)
subu $v1, $fp, 160
sw $s3 ,0($v1)
subu $v1, $fp, 164
sw $s4 ,0($v1)
subu $v1, $fp, 168
sw $s5 ,0($v1)
subu $v1, $fp, 172
sw $s6 ,0($v1)
subu $v1, $fp, 176
sw $s7 ,0($v1)
subu $v1, $fp, 180
sw $t1 ,0($v1)
subu $v1, $fp, 184
sw $t2 ,0($v1)
subu $v1, $fp, 188
sw $t0 ,0($v1)
subu $v1, $fp, 192
sw $t6 ,0($v1)
subu $v1, $fp, 196
sw $t7 ,0($v1)
subu $v1, $fp, 200
sw $t3 ,0($v1)
subu $v1, $fp, 204
sw $t5 ,0($v1)
subu $v1, $fp, 208
sw $t9 ,0($v1)
subu $v1, $fp, 212
sw $s1 ,0($v1)
subu $v1, $fp, 216
sw $s2 ,0($v1)
subu $v1, $fp, 220
sw $t8 ,0($v1)
subu $v0, $fp, 152
sw $s0, 0($v0)
lw $s0, 0($s3)
subu $v0, $fp, 164
sw $s4, 0($v0)
lw $s4, 0($s2)
bgt $s0, $s4, label18
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 160
sw $s3, 0($v0)
subu $v0, $fp, 168
sw $s5, 0($v0)
subu $v0, $fp, 172
sw $s6, 0($v0)
subu $v0, $fp, 176
sw $s7, 0($v0)
subu $v0, $fp, 180
sw $t1, 0($v0)
subu $v0, $fp, 184
sw $t2, 0($v0)
subu $v0, $fp, 188
sw $t0, 0($v0)
subu $v0, $fp, 192
sw $t6, 0($v0)
subu $v0, $fp, 196
sw $t7, 0($v0)
subu $v0, $fp, 200
sw $t3, 0($v0)
subu $v0, $fp, 204
sw $t5, 0($v0)
subu $v0, $fp, 208
sw $t9, 0($v0)
subu $v0, $fp, 212
sw $s1, 0($v0)
subu $v0, $fp, 216
sw $s2, 0($v0)
subu $v0, $fp, 220
sw $t8, 0($v0)
subu $v0, $fp, 224
sw $s0, 0($v0)
subu $v0, $fp, 228
sw $s4, 0($v0)
j label19
label18:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 60
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 32
lw $t6, 0($v0)
li $t7, 12
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
subu $v0, $fp, 36
lw $s1, 0($v0)
li $s2, 4
mul $s0, $s2, $s1
move $s4, $t8
add $s3, $s4, $s0
subu $v0, $fp, 40
lw $s6, 0($v0)
lw $s7, 0($s3)
add $s5, $s6, $s7
move $s6, $s5
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t6, 0($v0)
subu $v0, $fp, 36
sw $s1, 0($v0)
subu $v0, $fp, 40
sw $s6, 0($v0)
subu $v0, $fp, 232
sw $t0, 0($v0)
subu $v0, $fp, 236
sw $t2, 0($v0)
subu $v0, $fp, 240
sw $t3, 0($v0)
subu $v0, $fp, 244
sw $t5, 0($v0)
subu $v0, $fp, 248
sw $t7, 0($v0)
subu $v0, $fp, 252
sw $t8, 0($v0)
subu $v0, $fp, 256
sw $t9, 0($v0)
subu $v0, $fp, 260
sw $s0, 0($v0)
subu $v0, $fp, 264
sw $s2, 0($v0)
subu $v0, $fp, 268
sw $s3, 0($v0)
subu $v0, $fp, 272
sw $s4, 0($v0)
subu $v0, $fp, 276
sw $s5, 0($v0)
subu $v0, $fp, 280
sw $s7, 0($v0)
label19:
subu $v0, $fp, 36
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 36
sw $t1, 0($v0)
subu $v0, $fp, 284
sw $t0, 0($v0)
j label15
label17:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 288
sw $t0, 0($v0)
j label12
label14:
subu $v0, $fp, 28
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 292
sw $t0, 0($v0)
j label9
label11:
subu $v0, $fp, 40
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

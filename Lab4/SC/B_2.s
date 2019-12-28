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


countSort:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 1176
subu $sp, $sp, 20
move $t0, $sp
subu $sp, $sp, 40
move $t1, $sp
subu $sp, $sp, 20
move $t2, $sp
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
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 10
blt $t0, $t1, label1
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 0
sw $t5, 0($t3)
addi $t6, $t1, 1
move $t1, $t6
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 36
sw $t2, 0($v0)
subu $v0, $fp, 40
sw $t3, 0($v0)
subu $v0, $fp, 44
sw $t5, 0($v0)
subu $v0, $fp, 48
sw $t6, 0($v0)
j label0
label2:
subu $v0, $fp, 24
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 24
sw $t0, 0($v0)
label3:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label4
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 52
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
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t5, $v0
sw $t5, 0($t3)
li $t7, 4
mul $t6, $t7, $t1
add $t8, $t4, $t6
lw $s0, 0($t8)
li $s1, 4
mul $t9, $s1, $s0
subu $v0, $fp, 16
lw $s3, 0($v0)
add $s2, $s3, $t9
li $s5, 4
mul $s4, $s5, $t1
add $s6, $t4, $s4
subu $v0, $fp, 60
sw $t2, 0($v0)
lw $t2, 0($s6)
subu $v0, $fp, 56
sw $t0, 0($v0)
li $t0, 4
mul $s7, $t0, $t2
subu $v0, $fp, 64
sw $t3, 0($v0)
add $t3, $s3, $s7
subu $v0, $fp, 68
sw $t5, 0($v0)
subu $v0, $fp, 76
sw $t7, 0($v0)
lw $t7, 0($t3)
addi $t5, $t7, 1
sw $t5, 0($s2)
subu $v0, $fp, 72
sw $t6, 0($v0)
addi $t6, $t1, 1
move $t1, $t6
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $s3, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 80
sw $t8, 0($v0)
subu $v0, $fp, 84
sw $t9, 0($v0)
subu $v0, $fp, 88
sw $s0, 0($v0)
subu $v0, $fp, 92
sw $s1, 0($v0)
subu $v0, $fp, 96
sw $s2, 0($v0)
subu $v0, $fp, 100
sw $s4, 0($v0)
subu $v0, $fp, 104
sw $s5, 0($v0)
subu $v0, $fp, 108
sw $s6, 0($v0)
subu $v0, $fp, 112
sw $s7, 0($v0)
subu $v0, $fp, 116
sw $t2, 0($v0)
subu $v0, $fp, 120
sw $t0, 0($v0)
subu $v0, $fp, 124
sw $t3, 0($v0)
subu $v0, $fp, 128
sw $t5, 0($v0)
subu $v0, $fp, 132
sw $t7, 0($v0)
subu $v0, $fp, 136
sw $t6, 0($v0)
j label3
label5:
subu $v0, $fp, 24
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 24
sw $t0, 0($v0)
label6:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 10
blt $t0, $t1, label7
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 140
sw $t1, 0($v0)
j label8
label7:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t6, 4
mul $t5, $t6, $t1
add $t7, $t4, $t5
addi $t8, $t1, -1
li $s0, 4
mul $t9, $s0, $t8
add $s1, $t4, $t9
lw $s3, 0($t7)
lw $s4, 0($s1)
add $s2, $s3, $s4
sw $s2, 0($t3)
addi $s5, $t1, 1
move $t1, $s5
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 144
sw $t0, 0($v0)
subu $v0, $fp, 148
sw $t2, 0($v0)
subu $v0, $fp, 152
sw $t3, 0($v0)
subu $v0, $fp, 156
sw $t5, 0($v0)
subu $v0, $fp, 160
sw $t6, 0($v0)
subu $v0, $fp, 164
sw $t7, 0($v0)
subu $v0, $fp, 168
sw $t8, 0($v0)
subu $v0, $fp, 172
sw $t9, 0($v0)
subu $v0, $fp, 176
sw $s0, 0($v0)
subu $v0, $fp, 180
sw $s1, 0($v0)
subu $v0, $fp, 184
sw $s2, 0($v0)
subu $v0, $fp, 188
sw $s3, 0($v0)
subu $v0, $fp, 192
sw $s4, 0($v0)
subu $v0, $fp, 196
sw $s5, 0($v0)
j label6
label8:
subu $v0, $fp, 24
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 24
sw $t0, 0($v0)
label9:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label10
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 200
sw $t1, 0($v0)
j label11
label10:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t6, 0($t3)
li $t7, 4
mul $t5, $t7, $t6
subu $v0, $fp, 16
lw $t9, 0($v0)
add $t8, $t9, $t5
lw $s1, 0($t8)
addi $s0, $s1, -1
li $s3, 4
mul $s2, $s3, $s0
subu $v0, $fp, 20
lw $s5, 0($v0)
add $s4, $s5, $s2
li $s7, 4
mul $s6, $s7, $t1
subu $v0, $fp, 208
sw $t2, 0($v0)
add $t2, $t4, $s6
subu $v0, $fp, 204
sw $t0, 0($v0)
lw $t0, 0($t2)
sw $t0, 0($s4)
subu $v0, $fp, 212
sw $t3, 0($v0)
subu $v0, $fp, 220
sw $t6, 0($v0)
li $t6, 4
mul $t3, $t6, $t1
subu $v0, $fp, 224
sw $t7, 0($v0)
add $t7, $t4, $t3
subu $v0, $fp, 216
sw $t5, 0($v0)
subu $v0, $fp, 16
sw $t9, 0($v0)
lw $t9, 0($t7)
subu $v0, $fp, 228
sw $t8, 0($v0)
li $t8, 4
mul $t5, $t8, $t9
subu $v0, $fp, 236
sw $s1, 0($v0)
subu $v0, $fp, 232
sw $s0, 0($v0)
subu $v0, $fp, 16
lw $s0, 0($v0)
add $s1, $s0, $t5
subu $v0, $fp, 244
sw $s3, 0($v0)
subu $v0, $fp, 240
sw $s2, 0($v0)
li $s2, 4
mul $s3, $s2, $t1
subu $v0, $fp, 20
sw $s5, 0($v0)
add $s5, $t4, $s3
subu $v0, $fp, 256
sw $s7, 0($v0)
subu $v0, $fp, 252
sw $s6, 0($v0)
lw $s6, 0($s5)
subu $v0, $fp, 264
sw $t0, 0($v0)
li $t0, 4
mul $s7, $t0, $s6
subu $v0, $fp, 260
sw $t2, 0($v0)
add $t2, $s0, $s7
subu $v0, $fp, 248
sw $s4, 0($v0)
subu $v0, $fp, 272
sw $t6, 0($v0)
lw $t6, 0($t2)
addi $s4, $t6, -1
sw $s4, 0($s1)
subu $v0, $fp, 268
sw $t3, 0($v0)
addi $t3, $t1, 1
move $t1, $t3
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $s0, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 276
sw $t7, 0($v0)
subu $v0, $fp, 280
sw $t5, 0($v0)
subu $v0, $fp, 284
sw $t9, 0($v0)
subu $v0, $fp, 288
sw $t8, 0($v0)
subu $v0, $fp, 292
sw $s1, 0($v0)
subu $v0, $fp, 296
sw $s3, 0($v0)
subu $v0, $fp, 300
sw $s2, 0($v0)
subu $v0, $fp, 304
sw $s5, 0($v0)
subu $v0, $fp, 308
sw $s7, 0($v0)
subu $v0, $fp, 312
sw $s6, 0($v0)
subu $v0, $fp, 316
sw $t0, 0($v0)
subu $v0, $fp, 320
sw $t2, 0($v0)
subu $v0, $fp, 324
sw $s4, 0($v0)
subu $v0, $fp, 328
sw $t6, 0($v0)
subu $v0, $fp, 332
sw $t3, 0($v0)
j label9
label11:
subu $v0, $fp, 24
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 24
sw $t0, 0($v0)
label12:
subu $v0, $fp, 24
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label13
subu $v0, $fp, 24
sw $t0, 0($v0)
subu $v0, $fp, 336
sw $t1, 0($v0)
j label14
label13:
subu $v0, $fp, 24
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 20
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
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 340
sw $t0, 0($v0)
subu $v0, $fp, 344
sw $t2, 0($v0)
subu $v0, $fp, 348
sw $t3, 0($v0)
subu $v0, $fp, 352
sw $t5, 0($v0)
subu $v0, $fp, 356
sw $t6, 0($v0)
j label12
label14:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

bubbleSort:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 804
subu $sp, $sp, 20
move $t0, $sp
li  $t1, 0
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 16
sw $t1, 0($v0)
label15:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label16
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
j label17
label16:
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
j label15
label17:
li  $t0, 1
subu $v0, $fp, 44
sw $t0, 0($v0)
label18:
subu $v0, $fp, 44
lw $t0, 0($v0)
li $t1, 1
beq $t0, $t1, label19
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label20
label19:
subu $v0, $fp, 44
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 16
lw $t1, 0($v0)
li  $t1, 1
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 44
sw $t0, 0($v0)
label21:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label22
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 52
sw $t1, 0($v0)
j label23
label22:
subu $v0, $fp, 16
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $t5, $t1, -1
li $t7, 4
mul $t6, $t7, $t5
add $t8, $t4, $t6
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
subu $v1, $fp, 56
sw $t0 ,0($v1)
subu $v1, $fp, 60
sw $t2 ,0($v1)
subu $v1, $fp, 64
sw $t3 ,0($v1)
subu $v1, $fp, 68
sw $t5 ,0($v1)
subu $v1, $fp, 72
sw $t6 ,0($v1)
subu $v1, $fp, 76
sw $t7 ,0($v1)
subu $v1, $fp, 80
sw $t8 ,0($v1)
lw $t9, 0($t3)
lw $s0, 0($t8)
blt $t9, $s0, label24
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
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
subu $v0, $fp, 76
sw $t7, 0($v0)
subu $v0, $fp, 80
sw $t8, 0($v0)
subu $v0, $fp, 84
sw $t9, 0($v0)
subu $v0, $fp, 88
sw $s0, 0($v0)
j label25
label24:
subu $v0, $fp, 44
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 16
lw $t2, 0($v0)
addi $t1, $t2, -1
li $t4, 4
mul $t3, $t4, $t1
subu $v0, $fp, 12
lw $t6, 0($v0)
add $t5, $t6, $t3
lw  $t7, 0($t5)
addi $t8, $t2, -1
li $s0, 4
mul $t9, $s0, $t8
add $s1, $t6, $t9
li $s3, 4
mul $s2, $s3, $t2
add $s4, $t6, $s2
lw $s5, 0($s4)
sw $s5, 0($s1)
li $s7, 4
mul $s6, $s7, $t2
subu $v0, $fp, 44
sw $t0, 0($v0)
add $t0, $t6, $s6
sw $t7, 0($t0)
subu $v0, $fp, 12
sw $t6, 0($v0)
subu $v0, $fp, 16
sw $t2, 0($v0)
subu $v0, $fp, 92
sw $t1, 0($v0)
subu $v0, $fp, 96
sw $t3, 0($v0)
subu $v0, $fp, 100
sw $t4, 0($v0)
subu $v0, $fp, 104
sw $t5, 0($v0)
subu $v0, $fp, 108
sw $t7, 0($v0)
subu $v0, $fp, 112
sw $t8, 0($v0)
subu $v0, $fp, 116
sw $t9, 0($v0)
subu $v0, $fp, 120
sw $s0, 0($v0)
subu $v0, $fp, 124
sw $s1, 0($v0)
subu $v0, $fp, 128
sw $s2, 0($v0)
subu $v0, $fp, 132
sw $s3, 0($v0)
subu $v0, $fp, 136
sw $s4, 0($v0)
subu $v0, $fp, 140
sw $s5, 0($v0)
subu $v0, $fp, 144
sw $s6, 0($v0)
subu $v0, $fp, 148
sw $s7, 0($v0)
subu $v0, $fp, 152
sw $t0, 0($v0)
label25:
subu $v0, $fp, 16
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 156
sw $t0, 0($v0)
j label21
label23:
j label18
label20:
subu $v0, $fp, 16
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 16
sw $t0, 0($v0)
label26:
subu $v0, $fp, 16
lw $t0, 0($v0)
li $t1, 5
blt $t0, $t1, label27
subu $v0, $fp, 16
sw $t0, 0($v0)
subu $v0, $fp, 160
sw $t1, 0($v0)
j label28
label27:
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
subu $v0, $fp, 164
sw $t0, 0($v0)
subu $v0, $fp, 168
sw $t2, 0($v0)
subu $v0, $fp, 172
sw $t3, 0($v0)
subu $v0, $fp, 176
sw $t5, 0($v0)
subu $v0, $fp, 180
sw $t6, 0($v0)
j label26
label28:
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
subu $sp, $sp, 36
jal countSort
move $t0, $v0
subu $v1, $fp, 12
sw $t0 ,0($v1)
jal bubbleSort
move $t0, $v0
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

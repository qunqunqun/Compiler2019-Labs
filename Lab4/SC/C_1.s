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
subu $sp, $sp, 2412
subu $sp, $sp, 32
move $t0, $sp
subu $sp, $sp, 32
move $t1, $sp
subu $sp, $sp, 32
move $t2, $sp
subu $sp, $sp, 32
move $t3, $sp
li  $t4, 0
li  $t5, 0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t6, $v0
move $t7, $t6
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
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 40
lw $t1, 0($v0)
blt $t0, $t1, label1
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 32
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t6, 0
addi $t5, $t6, -1
sw $t5, 0($t3)
addi $t7, $t1, 1
move $t1, $t7
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 44
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 52
sw $t3, 0($v0)
subu $v0, $fp, 56
sw $t5, 0($v0)
subu $v0, $fp, 60
sw $t6, 0($v0)
subu $v0, $fp, 64
sw $t7, 0($v0)
j label0
label2:
subu $v0, $fp, 32
lw $t0, 0($v0)
li  $t0, 0
li  $t1, 1
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 68
sw $t1, 0($v0)
label3:
subu $v0, $fp, 68
lw $t0, 0($v0)
li $t1, 1
beq $t0, $t1, label4
subu $v0, $fp, 68
sw $t0, 0($v0)
subu $v0, $fp, 72
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 40
lw $t1, 0($v0)
beq $t0, $t1, label6
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
j label7
label6:
li  $t0, 1
li  $t1, 0
subu $v0, $fp, 76
sw $t0, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
label9:
subu $v0, $fp, 80
lw $t0, 0($v0)
subu $v0, $fp, 40
lw $t1, 0($v0)
blt $t0, $t1, label10
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 80
sw $t0, 0($v0)
j label11
label10:
subu $v0, $fp, 80
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 1
sw $t5, 0($t3)
li $t7, 4
mul $t6, $t7, $t1
subu $v0, $fp, 20
lw $t9, 0($v0)
add $t8, $t9, $t6
li $s0, 1
sw $s0, 0($t8)
li $s2, 4
mul $s1, $s2, $t1
subu $v0, $fp, 24
lw $s4, 0($v0)
add $s3, $s4, $s1
li $s5, 1
sw $s5, 0($s3)
addi $s6, $t1, 1
move $t1, $s6
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 20
sw $t9, 0($v0)
subu $v0, $fp, 24
sw $s4, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 84
sw $t0, 0($v0)
subu $v0, $fp, 88
sw $t2, 0($v0)
subu $v0, $fp, 92
sw $t3, 0($v0)
subu $v0, $fp, 96
sw $t5, 0($v0)
subu $v0, $fp, 100
sw $t6, 0($v0)
subu $v0, $fp, 104
sw $t7, 0($v0)
subu $v0, $fp, 108
sw $t8, 0($v0)
subu $v0, $fp, 112
sw $s0, 0($v0)
subu $v0, $fp, 116
sw $s1, 0($v0)
subu $v0, $fp, 120
sw $s2, 0($v0)
subu $v0, $fp, 124
sw $s3, 0($v0)
subu $v0, $fp, 128
sw $s5, 0($v0)
subu $v0, $fp, 132
sw $s6, 0($v0)
j label9
label11:
subu $v0, $fp, 80
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 80
sw $t0, 0($v0)
label12:
subu $v0, $fp, 80
lw $t0, 0($v0)
subu $v0, $fp, 40
lw $t1, 0($v0)
blt $t0, $t1, label13
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 80
sw $t0, 0($v0)
j label14
label13:
subu $v0, $fp, 80
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
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 16
sw $t9 ,0($v1)
subu $v1, $fp, 80
sw $t1 ,0($v1)
subu $v1, $fp, 136
sw $t0 ,0($v1)
subu $v1, $fp, 140
sw $t2 ,0($v1)
subu $v1, $fp, 144
sw $t3 ,0($v1)
subu $v1, $fp, 148
sw $t5 ,0($v1)
subu $v1, $fp, 152
sw $t6 ,0($v1)
subu $v1, $fp, 156
sw $t7 ,0($v1)
subu $v1, $fp, 160
sw $t8 ,0($v1)
lw $s0, 0($t8)
li $s1, 1
bne $s0, $s1, label15
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $t9, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 136
sw $t0, 0($v0)
subu $v0, $fp, 140
sw $t2, 0($v0)
subu $v0, $fp, 144
sw $t3, 0($v0)
subu $v0, $fp, 148
sw $t5, 0($v0)
subu $v0, $fp, 152
sw $t6, 0($v0)
subu $v0, $fp, 156
sw $t7, 0($v0)
subu $v0, $fp, 160
sw $t8, 0($v0)
subu $v0, $fp, 164
sw $s0, 0($v0)
subu $v0, $fp, 168
sw $s1, 0($v0)
j label19
label19:
subu $v0, $fp, 80
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t6, 0($t3)
li $t7, 4
mul $t5, $t7, $t6
subu $v0, $fp, 20
lw $t9, 0($v0)
add $t8, $t9, $t5
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 20
sw $t9 ,0($v1)
subu $v1, $fp, 80
sw $t1 ,0($v1)
subu $v1, $fp, 172
sw $t0 ,0($v1)
subu $v1, $fp, 176
sw $t2 ,0($v1)
subu $v1, $fp, 180
sw $t3 ,0($v1)
subu $v1, $fp, 184
sw $t5 ,0($v1)
subu $v1, $fp, 188
sw $t6 ,0($v1)
subu $v1, $fp, 192
sw $t7 ,0($v1)
subu $v1, $fp, 196
sw $t8 ,0($v1)
lw $s0, 0($t8)
li $s1, 1
bne $s0, $s1, label15
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 20
sw $t9, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 172
sw $t0, 0($v0)
subu $v0, $fp, 176
sw $t2, 0($v0)
subu $v0, $fp, 180
sw $t3, 0($v0)
subu $v0, $fp, 184
sw $t5, 0($v0)
subu $v0, $fp, 188
sw $t6, 0($v0)
subu $v0, $fp, 192
sw $t7, 0($v0)
subu $v0, $fp, 196
sw $t8, 0($v0)
subu $v0, $fp, 200
sw $s0, 0($v0)
subu $v0, $fp, 204
sw $s1, 0($v0)
j label18
label18:
subu $v0, $fp, 80
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t6, 0($t3)
li $t7, 4
mul $t5, $t7, $t6
subu $v0, $fp, 24
lw $t9, 0($v0)
add $t8, $t9, $t5
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 24
sw $t9 ,0($v1)
subu $v1, $fp, 80
sw $t1 ,0($v1)
subu $v1, $fp, 208
sw $t0 ,0($v1)
subu $v1, $fp, 212
sw $t2 ,0($v1)
subu $v1, $fp, 216
sw $t3 ,0($v1)
subu $v1, $fp, 220
sw $t5 ,0($v1)
subu $v1, $fp, 224
sw $t6 ,0($v1)
subu $v1, $fp, 228
sw $t7 ,0($v1)
subu $v1, $fp, 232
sw $t8 ,0($v1)
lw $s0, 0($t8)
li $s1, 1
bne $s0, $s1, label15
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t9, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 208
sw $t0, 0($v0)
subu $v0, $fp, 212
sw $t2, 0($v0)
subu $v0, $fp, 216
sw $t3, 0($v0)
subu $v0, $fp, 220
sw $t5, 0($v0)
subu $v0, $fp, 224
sw $t6, 0($v0)
subu $v0, $fp, 228
sw $t7, 0($v0)
subu $v0, $fp, 232
sw $t8, 0($v0)
subu $v0, $fp, 236
sw $s0, 0($v0)
subu $v0, $fp, 240
sw $s1, 0($v0)
j label16
label15:
subu $v0, $fp, 76
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 80
lw $t1, 0($v0)
subu $v0, $fp, 40
lw $t2, 0($v0)
move $t1, $t2
subu $v0, $fp, 40
sw $t2, 0($v0)
subu $v0, $fp, 76
sw $t0, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
j label17
label16:
subu $v0, $fp, 80
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
li $s0, 0
sw $s0, 0($t8)
li  $s1, 0
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $t9, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 244
sw $t0, 0($v0)
subu $v0, $fp, 248
sw $t2, 0($v0)
subu $v0, $fp, 252
sw $t3, 0($v0)
subu $v0, $fp, 256
sw $t5, 0($v0)
subu $v0, $fp, 260
sw $t6, 0($v0)
subu $v0, $fp, 264
sw $t7, 0($v0)
subu $v0, $fp, 268
sw $t8, 0($v0)
subu $v0, $fp, 272
sw $s0, 0($v0)
subu $v0, $fp, 276
sw $s1, 0($v0)
label20:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v1, $fp, 40
sw $t1 ,0($v1)
subu $v1, $fp, 280
sw $t0 ,0($v1)
subu $v0, $fp, 276
lw $t2, 0($v0)
blt $t2, $t0, label21
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 276
sw $t2, 0($v0)
subu $v0, $fp, 280
sw $t0, 0($v0)
j label22
label21:
subu $v0, $fp, 276
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 20
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $t5, $t1, 1
li $t7, 4
mul $t6, $t7, $t5
add $t8, $t4, $t6
lw $t9, 0($t8)
sw $t9, 0($t3)
addi $s0, $t1, 1
move $t1, $s0
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 276
sw $t1, 0($v0)
subu $v0, $fp, 284
sw $t0, 0($v0)
subu $v0, $fp, 288
sw $t2, 0($v0)
subu $v0, $fp, 292
sw $t3, 0($v0)
subu $v0, $fp, 296
sw $t5, 0($v0)
subu $v0, $fp, 300
sw $t6, 0($v0)
subu $v0, $fp, 304
sw $t7, 0($v0)
subu $v0, $fp, 308
sw $t8, 0($v0)
subu $v0, $fp, 312
sw $t9, 0($v0)
subu $v0, $fp, 316
sw $s0, 0($v0)
j label20
label22:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, -1
li $t3, 4
mul $t2, $t3, $t0
subu $v0, $fp, 20
lw $t5, 0($v0)
add $t4, $t5, $t2
li $t6, 1
sw $t6, 0($t4)
subu $v0, $fp, 80
lw $t8, 0($v0)
li $t9, 4
mul $t7, $t9, $t8
subu $v0, $fp, 12
lw $s1, 0($v0)
add $s0, $s1, $t7
subu $v1, $fp, 12
sw $s1 ,0($v1)
subu $v1, $fp, 20
sw $t5 ,0($v1)
subu $v1, $fp, 40
sw $t1 ,0($v1)
subu $v1, $fp, 80
sw $t8 ,0($v1)
subu $v1, $fp, 320
sw $t0 ,0($v1)
subu $v1, $fp, 324
sw $t2 ,0($v1)
subu $v1, $fp, 328
sw $t3 ,0($v1)
subu $v1, $fp, 332
sw $t4 ,0($v1)
subu $v1, $fp, 336
sw $t6 ,0($v1)
subu $v1, $fp, 340
sw $t7 ,0($v1)
subu $v1, $fp, 344
sw $t9 ,0($v1)
subu $v1, $fp, 348
sw $s0 ,0($v1)
lw $s2, 0($s0)
li $s3, 0
bne $s2, $s3, label23
subu $v0, $fp, 12
sw $s1, 0($v0)
subu $v0, $fp, 20
sw $t5, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 80
sw $t8, 0($v0)
subu $v0, $fp, 320
sw $t0, 0($v0)
subu $v0, $fp, 324
sw $t2, 0($v0)
subu $v0, $fp, 328
sw $t3, 0($v0)
subu $v0, $fp, 332
sw $t4, 0($v0)
subu $v0, $fp, 336
sw $t6, 0($v0)
subu $v0, $fp, 340
sw $t7, 0($v0)
subu $v0, $fp, 344
sw $t9, 0($v0)
subu $v0, $fp, 348
sw $s0, 0($v0)
subu $v0, $fp, 352
sw $s2, 0($v0)
subu $v0, $fp, 356
sw $s3, 0($v0)
j label24
label23:
subu $v0, $fp, 80
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t6, 0($t3)
addi $t5, $t6, -1
li $t8, 4
mul $t7, $t8, $t5
subu $v0, $fp, 20
lw $s0, 0($v0)
add $t9, $s0, $t7
li $s1, 0
sw $s1, 0($t9)
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 20
sw $s0, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 360
sw $t0, 0($v0)
subu $v0, $fp, 364
sw $t2, 0($v0)
subu $v0, $fp, 368
sw $t3, 0($v0)
subu $v0, $fp, 372
sw $t5, 0($v0)
subu $v0, $fp, 376
sw $t6, 0($v0)
subu $v0, $fp, 380
sw $t7, 0($v0)
subu $v0, $fp, 384
sw $t8, 0($v0)
subu $v0, $fp, 388
sw $t9, 0($v0)
subu $v0, $fp, 392
sw $s1, 0($v0)
label24:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v0, $fp, 276
lw $t2, 0($v0)
move $t2, $t0
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 276
sw $t2, 0($v0)
subu $v0, $fp, 396
sw $t0, 0($v0)
label25:
subu $v0, $fp, 276
lw $t0, 0($v0)
li $t1, 0
bgt $t0, $t1, label26
subu $v0, $fp, 276
sw $t0, 0($v0)
subu $v0, $fp, 400
sw $t1, 0($v0)
j label27
label26:
subu $v0, $fp, 276
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 24
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $t5, $t1, -1
li $t7, 4
mul $t6, $t7, $t5
add $t8, $t4, $t6
lw $t9, 0($t8)
sw $t9, 0($t3)
addi $s0, $t1, -1
move $t1, $s0
subu $v0, $fp, 24
sw $t4, 0($v0)
subu $v0, $fp, 276
sw $t1, 0($v0)
subu $v0, $fp, 404
sw $t0, 0($v0)
subu $v0, $fp, 408
sw $t2, 0($v0)
subu $v0, $fp, 412
sw $t3, 0($v0)
subu $v0, $fp, 416
sw $t5, 0($v0)
subu $v0, $fp, 420
sw $t6, 0($v0)
subu $v0, $fp, 424
sw $t7, 0($v0)
subu $v0, $fp, 428
sw $t8, 0($v0)
subu $v0, $fp, 432
sw $t9, 0($v0)
subu $v0, $fp, 436
sw $s0, 0($v0)
j label25
label27:
li $t1, 4
li $t2, 0
mul $t0, $t1, $t2
subu $v0, $fp, 24
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 1
sw $t5, 0($t3)
subu $v0, $fp, 80
lw $t7, 0($v0)
li $t8, 4
mul $t6, $t8, $t7
subu $v0, $fp, 12
lw $s0, 0($v0)
add $t9, $s0, $t6
subu $v0, $fp, 40
lw $s2, 0($v0)
addi $s1, $s2, -1
subu $v1, $fp, 12
sw $s0 ,0($v1)
subu $v1, $fp, 24
sw $t4 ,0($v1)
subu $v1, $fp, 40
sw $s2 ,0($v1)
subu $v1, $fp, 80
sw $t7 ,0($v1)
subu $v1, $fp, 440
sw $t0 ,0($v1)
subu $v1, $fp, 444
sw $t1 ,0($v1)
subu $v1, $fp, 448
sw $t2 ,0($v1)
subu $v1, $fp, 452
sw $t3 ,0($v1)
subu $v1, $fp, 456
sw $t5 ,0($v1)
subu $v1, $fp, 460
sw $t6 ,0($v1)
subu $v1, $fp, 464
sw $t8 ,0($v1)
subu $v1, $fp, 468
sw $t9 ,0($v1)
subu $v1, $fp, 472
sw $s1 ,0($v1)
lw $s3, 0($t9)
bne $s3, $s1, label28
subu $v0, $fp, 12
sw $s0, 0($v0)
subu $v0, $fp, 24
sw $t4, 0($v0)
subu $v0, $fp, 40
sw $s2, 0($v0)
subu $v0, $fp, 80
sw $t7, 0($v0)
subu $v0, $fp, 440
sw $t0, 0($v0)
subu $v0, $fp, 444
sw $t1, 0($v0)
subu $v0, $fp, 448
sw $t2, 0($v0)
subu $v0, $fp, 452
sw $t3, 0($v0)
subu $v0, $fp, 456
sw $t5, 0($v0)
subu $v0, $fp, 460
sw $t6, 0($v0)
subu $v0, $fp, 464
sw $t8, 0($v0)
subu $v0, $fp, 468
sw $t9, 0($v0)
subu $v0, $fp, 472
sw $s1, 0($v0)
subu $v0, $fp, 476
sw $s3, 0($v0)
j label29
label28:
subu $v0, $fp, 80
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
lw $t6, 0($t3)
addi $t5, $t6, 1
li $t8, 4
mul $t7, $t8, $t5
subu $v0, $fp, 24
lw $s0, 0($v0)
add $t9, $s0, $t7
li $s1, 0
sw $s1, 0($t9)
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $s0, 0($v0)
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 480
sw $t0, 0($v0)
subu $v0, $fp, 484
sw $t2, 0($v0)
subu $v0, $fp, 488
sw $t3, 0($v0)
subu $v0, $fp, 492
sw $t5, 0($v0)
subu $v0, $fp, 496
sw $t6, 0($v0)
subu $v0, $fp, 500
sw $t7, 0($v0)
subu $v0, $fp, 504
sw $t8, 0($v0)
subu $v0, $fp, 508
sw $t9, 0($v0)
subu $v0, $fp, 512
sw $s1, 0($v0)
label29:
subu $v0, $fp, 80
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 80
sw $t1, 0($v0)
subu $v0, $fp, 516
sw $t0, 0($v0)
label17:
j label12
label14:
subu $v0, $fp, 76
lw $t0, 0($v0)
li $t1, 1
beq $t0, $t1, label30
subu $v0, $fp, 76
sw $t0, 0($v0)
subu $v0, $fp, 520
sw $t1, 0($v0)
j label31
label30:
subu $v0, $fp, 28
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 524
sw $t0, 0($v0)
label31:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, -1
move $t1, $t0
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 528
sw $t0, 0($v0)
j label8
label7:
label32:
subu $v0, $fp, 32
lw $t0, 0($v0)
li $t1, 0
bge $t0, $t1, label35
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 532
sw $t1, 0($v0)
j label34
label35:
subu $v0, $fp, 32
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 40
lw $t6, 0($v0)
addi $t5, $t6, -1
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 32
sw $t1 ,0($v1)
subu $v1, $fp, 40
sw $t6 ,0($v1)
subu $v1, $fp, 536
sw $t0 ,0($v1)
subu $v1, $fp, 540
sw $t2 ,0($v1)
subu $v1, $fp, 544
sw $t3 ,0($v1)
subu $v1, $fp, 548
sw $t5 ,0($v1)
lw $t7, 0($t3)
bge $t7, $t5, label33
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t6, 0($v0)
subu $v0, $fp, 536
sw $t0, 0($v0)
subu $v0, $fp, 540
sw $t2, 0($v0)
subu $v0, $fp, 544
sw $t3, 0($v0)
subu $v0, $fp, 548
sw $t5, 0($v0)
subu $v0, $fp, 552
sw $t7, 0($v0)
j label34
label33:
subu $v0, $fp, 32
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t6, 0
addi $t5, $t6, -1
sw $t5, 0($t3)
addi $t7, $t1, -1
move $t1, $t7
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 556
sw $t0, 0($v0)
subu $v0, $fp, 560
sw $t2, 0($v0)
subu $v0, $fp, 564
sw $t3, 0($v0)
subu $v0, $fp, 568
sw $t5, 0($v0)
subu $v0, $fp, 572
sw $t6, 0($v0)
subu $v0, $fp, 576
sw $t7, 0($v0)
j label32
label34:
li $t1, 0
addi $t0, $t1, -1
subu $v1, $fp, 580
sw $t0 ,0($v1)
subu $v1, $fp, 584
sw $t1 ,0($v1)
subu $v0, $fp, 32
lw $t2, 0($v0)
beq $t2, $t0, label36
subu $v0, $fp, 32
sw $t2, 0($v0)
subu $v0, $fp, 580
sw $t0, 0($v0)
subu $v0, $fp, 584
sw $t1, 0($v0)
j label37
label36:
subu $v0, $fp, 68
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 68
sw $t0, 0($v0)
j label38
label37:
subu $v0, $fp, 32
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t6, 4
mul $t5, $t6, $t1
add $t7, $t4, $t5
lw $t9, 0($t7)
addi $t8, $t9, 1
sw $t8, 0($t3)
addi $s0, $t1, 1
move $t1, $s0
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 588
sw $t0, 0($v0)
subu $v0, $fp, 592
sw $t2, 0($v0)
subu $v0, $fp, 596
sw $t3, 0($v0)
subu $v0, $fp, 600
sw $t5, 0($v0)
subu $v0, $fp, 604
sw $t6, 0($v0)
subu $v0, $fp, 608
sw $t7, 0($v0)
subu $v0, $fp, 612
sw $t8, 0($v0)
subu $v0, $fp, 616
sw $t9, 0($v0)
subu $v0, $fp, 620
sw $s0, 0($v0)
label38:
label8:
j label3
label5:
subu $v0, $fp, 28
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

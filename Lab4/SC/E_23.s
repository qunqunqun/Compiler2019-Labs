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


display:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 672
move $t0, $a0
move $t1, $a1
move $t2, $a2
subu $sp, $sp, 400
move $t3, $sp
li  $t4, 0
li  $t5, 0
li  $t6, 1
li $t8, 4
li $t9, 0
mul $t7, $t8, $t9
move $s1, $t1
add $s0, $s1, $t7
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
subu $v1, $fp, 52
sw $s0 ,0($v1)
subu $v1, $fp, 56
sw $s1 ,0($v1)
lw $s2, 0($s0)
li $s3, 1
beq $s2, $s3, label0
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
subu $v0, $fp, 52
sw $s0, 0($v0)
subu $v0, $fp, 56
sw $s1, 0($v0)
subu $v0, $fp, 60
sw $s2, 0($v0)
subu $v0, $fp, 64
sw $s3, 0($v0)
j label1
label0:
label2:
subu $v0, $fp, 28
lw $t0, 0($v0)
subu $v0, $fp, 20
lw $t1, 0($v0)
blt $t0, $t1, label3
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t0, 0($v0)
j label4
label3:
subu $v0, $fp, 32
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 36
lw $t1, 0($v0)
li  $t1, 1
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 36
sw $t1, 0($v0)
label5:
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 20
lw $t1, 0($v0)
blt $t0, $t1, label6
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t0, 0($v0)
j label7
label6:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 12
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 12
sw $t4 ,0($v1)
subu $v1, $fp, 28
sw $t1 ,0($v1)
subu $v1, $fp, 68
sw $t0 ,0($v1)
subu $v1, $fp, 72
sw $t2 ,0($v1)
subu $v1, $fp, 76
sw $t3 ,0($v1)
subu $v1, $fp, 80
sw $t5 ,0($v1)
subu $v0, $fp, 32
lw $t6, 0($v0)
lw $t7, 0($t3)
beq $t6, $t7, label8
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t6, 0($v0)
subu $v0, $fp, 68
sw $t0, 0($v0)
subu $v0, $fp, 72
sw $t2, 0($v0)
subu $v0, $fp, 76
sw $t3, 0($v0)
subu $v0, $fp, 80
sw $t5, 0($v0)
subu $v0, $fp, 84
sw $t7, 0($v0)
j label9
label8:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 40
mul $t0, $t2, $t1
subu $v0, $fp, 24
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 32
lw $t6, 0($v0)
li $t7, 4
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
li $s0, 1
sw $s0, 0($t8)
subu $v0, $fp, 36
lw $s2, 0($v0)
li $s3, 10
mul $s1, $s2, $s3
addi $s4, $s1, 1
move $s2, $s4
subu $v0, $fp, 24
sw $t4, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t6, 0($v0)
subu $v0, $fp, 36
sw $s2, 0($v0)
subu $v0, $fp, 88
sw $t0, 0($v0)
subu $v0, $fp, 92
sw $t2, 0($v0)
subu $v0, $fp, 96
sw $t3, 0($v0)
subu $v0, $fp, 100
sw $t5, 0($v0)
subu $v0, $fp, 104
sw $t7, 0($v0)
subu $v0, $fp, 108
sw $t8, 0($v0)
subu $v0, $fp, 112
sw $t9, 0($v0)
subu $v0, $fp, 116
sw $s0, 0($v0)
subu $v0, $fp, 120
sw $s1, 0($v0)
subu $v0, $fp, 124
sw $s3, 0($v0)
subu $v0, $fp, 128
sw $s4, 0($v0)
j label10
label9:
subu $v0, $fp, 28
lw $t1, 0($v0)
li $t2, 40
mul $t0, $t2, $t1
subu $v0, $fp, 24
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 32
lw $t6, 0($v0)
li $t7, 4
mul $t5, $t7, $t6
move $t9, $t3
add $t8, $t9, $t5
li $s0, 0
sw $s0, 0($t8)
subu $v0, $fp, 36
lw $s2, 0($v0)
li $s3, 10
mul $s1, $s2, $s3
move $s2, $s1
subu $v0, $fp, 24
sw $t4, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 32
sw $t6, 0($v0)
subu $v0, $fp, 36
sw $s2, 0($v0)
subu $v0, $fp, 132
sw $t0, 0($v0)
subu $v0, $fp, 136
sw $t2, 0($v0)
subu $v0, $fp, 140
sw $t3, 0($v0)
subu $v0, $fp, 144
sw $t5, 0($v0)
subu $v0, $fp, 148
sw $t7, 0($v0)
subu $v0, $fp, 152
sw $t8, 0($v0)
subu $v0, $fp, 156
sw $t9, 0($v0)
subu $v0, $fp, 160
sw $s0, 0($v0)
subu $v0, $fp, 164
sw $s1, 0($v0)
subu $v0, $fp, 168
sw $s3, 0($v0)
label10:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 172
sw $t0, 0($v0)
j label5
label7:
subu $v0, $fp, 36
lw $t0, 0($v0)
move $a0, $t0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
subu $v0, $fp, 28
lw $t2, 0($v0)
addi $t1, $t2, 1
move $t2, $t1
subu $v0, $fp, 28
sw $t2, 0($v0)
subu $v0, $fp, 36
sw $t0, 0($v0)
subu $v0, $fp, 176
sw $t1, 0($v0)
j label2
label4:
label1:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra

dfs:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 1488
move $t0, $a0
move $t1, $a1
move $t2, $a2
move $t3, $a3
lw $t4, 0($fp)
lw $t5, 4($fp)
lw $t6, 8($fp)
li  $t7, 0
subu $sp, $sp, 40
move $t8, $sp
subu $sp, $sp, 40
move $t9, $sp
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
beq $t4, $t5, label11
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
j label12
label11:
li $t1, 4
li $t2, 0
mul $t0, $t1, $t2
subu $v0, $fp, 36
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
li $t7, 4
li $t8, 0
mul $t6, $t7, $t8
move $s0, $t4
add $t9, $s0, $t6
lw $s2, 0($t9)
addi $s1, $s2, 1
sw $s1, 0($t3)
subu $v1, $fp, 36
sw $t4 ,0($v1)
subu $v1, $fp, 52
sw $t0 ,0($v1)
subu $v1, $fp, 56
sw $t1 ,0($v1)
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
subu $v1, $fp, 84
sw $t9 ,0($v1)
subu $v1, $fp, 88
sw $s0 ,0($v1)
subu $v1, $fp, 92
sw $s1 ,0($v1)
subu $v1, $fp, 96
sw $s2 ,0($v1)
subu $v0, $fp, 12
lw $s3, 0($v0)
move $s4, $s3
move $a0, $s4
move $s5, $t4
move $a1, $s5
subu $v0, $fp, 32
lw $s6, 0($v0)
move $a2, $s6
jal display
move $t0, $v0
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra
subu $v0, $fp, 108
sw $t0, 0($v0)
label12:
label13:
subu $v0, $fp, 40
lw $t0, 0($v0)
subu $v0, $fp, 32
lw $t1, 0($v0)
blt $t0, $t1, label14
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t0, 0($v0)
j label15
label14:
subu $v0, $fp, 40
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 16
sw $t4 ,0($v1)
subu $v1, $fp, 40
sw $t1 ,0($v1)
subu $v1, $fp, 112
sw $t0 ,0($v1)
subu $v1, $fp, 116
sw $t2 ,0($v1)
subu $v1, $fp, 120
sw $t3 ,0($v1)
subu $v1, $fp, 124
sw $t5 ,0($v1)
lw $t6, 0($t3)
li $t7, 1
beq $t6, $t7, label19
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 112
sw $t0, 0($v0)
subu $v0, $fp, 116
sw $t2, 0($v0)
subu $v0, $fp, 120
sw $t3, 0($v0)
subu $v0, $fp, 124
sw $t5, 0($v0)
subu $v0, $fp, 128
sw $t6, 0($v0)
subu $v0, $fp, 132
sw $t7, 0($v0)
j label17
label19:
subu $v0, $fp, 40
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 20
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 20
sw $t4 ,0($v1)
subu $v1, $fp, 40
sw $t1 ,0($v1)
subu $v1, $fp, 136
sw $t0 ,0($v1)
subu $v1, $fp, 140
sw $t2 ,0($v1)
subu $v1, $fp, 144
sw $t3 ,0($v1)
subu $v1, $fp, 148
sw $t5 ,0($v1)
lw $t6, 0($t3)
li $t7, 1
beq $t6, $t7, label18
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 40
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
j label17
label18:
subu $v0, $fp, 40
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 24
lw $t4, 0($v0)
move $t5, $t4
add $t3, $t5, $t0
subu $v1, $fp, 24
sw $t4 ,0($v1)
subu $v1, $fp, 40
sw $t1 ,0($v1)
subu $v1, $fp, 160
sw $t0 ,0($v1)
subu $v1, $fp, 164
sw $t2 ,0($v1)
subu $v1, $fp, 168
sw $t3 ,0($v1)
subu $v1, $fp, 172
sw $t5 ,0($v1)
lw $t6, 0($t3)
li $t7, 1
beq $t6, $t7, label16
subu $v0, $fp, 24
sw $t4, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 160
sw $t0, 0($v0)
subu $v0, $fp, 164
sw $t2, 0($v0)
subu $v0, $fp, 168
sw $t3, 0($v0)
subu $v0, $fp, 172
sw $t5, 0($v0)
subu $v0, $fp, 176
sw $t6, 0($v0)
subu $v0, $fp, 180
sw $t7, 0($v0)
j label17
label16:
subu $v0, $fp, 28
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
li $t8, 4
mul $t7, $t8, $t6
subu $v0, $fp, 16
lw $s0, 0($v0)
move $s1, $s0
add $t9, $s1, $t7
li $s2, 0
sw $s2, 0($t9)
li  $s3, 0
subu $v0, $fp, 12
sw $t4, 0($v0)
subu $v0, $fp, 16
sw $s0, 0($v0)
subu $v0, $fp, 28
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t6, 0($v0)
subu $v0, $fp, 184
sw $t0, 0($v0)
subu $v0, $fp, 188
sw $t2, 0($v0)
subu $v0, $fp, 192
sw $t3, 0($v0)
subu $v0, $fp, 196
sw $t5, 0($v0)
subu $v0, $fp, 200
sw $t7, 0($v0)
subu $v0, $fp, 204
sw $t8, 0($v0)
subu $v0, $fp, 208
sw $t9, 0($v0)
subu $v0, $fp, 212
sw $s1, 0($v0)
subu $v0, $fp, 216
sw $s2, 0($v0)
subu $v0, $fp, 220
sw $s3, 0($v0)
label20:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v1, $fp, 32
sw $t1 ,0($v1)
subu $v1, $fp, 224
sw $t0 ,0($v1)
subu $v0, $fp, 220
lw $t2, 0($v0)
blt $t2, $t0, label21
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 220
sw $t2, 0($v0)
subu $v0, $fp, 224
sw $t0, 0($v0)
j label22
label21:
subu $v0, $fp, 220
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 44
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $t5, $t1, 1
li $t7, 4
mul $t6, $t7, $t5
subu $v0, $fp, 20
lw $t9, 0($v0)
move $s0, $t9
add $t8, $s0, $t6
lw $s1, 0($t8)
sw $s1, 0($t3)
addi $s2, $t1, 1
move $t1, $s2
subu $v0, $fp, 20
sw $t9, 0($v0)
subu $v0, $fp, 44
sw $t4, 0($v0)
subu $v0, $fp, 220
sw $t1, 0($v0)
subu $v0, $fp, 228
sw $t0, 0($v0)
subu $v0, $fp, 232
sw $t2, 0($v0)
subu $v0, $fp, 236
sw $t3, 0($v0)
subu $v0, $fp, 240
sw $t5, 0($v0)
subu $v0, $fp, 244
sw $t6, 0($v0)
subu $v0, $fp, 248
sw $t7, 0($v0)
subu $v0, $fp, 252
sw $t8, 0($v0)
subu $v0, $fp, 256
sw $s0, 0($v0)
subu $v0, $fp, 260
sw $s1, 0($v0)
subu $v0, $fp, 264
sw $s2, 0($v0)
j label20
label22:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, -1
li $t3, 4
mul $t2, $t3, $t0
subu $v0, $fp, 44
lw $t5, 0($v0)
add $t4, $t5, $t2
li $t6, 1
sw $t6, 0($t4)
subu $v1, $fp, 32
sw $t1 ,0($v1)
subu $v1, $fp, 44
sw $t5 ,0($v1)
subu $v1, $fp, 268
sw $t0 ,0($v1)
subu $v1, $fp, 272
sw $t2 ,0($v1)
subu $v1, $fp, 276
sw $t3 ,0($v1)
subu $v1, $fp, 280
sw $t4 ,0($v1)
subu $v1, $fp, 284
sw $t6 ,0($v1)
subu $v0, $fp, 40
lw $t7, 0($v0)
li $t8, 0
bne $t7, $t8, label23
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
subu $v0, $fp, 44
sw $t5, 0($v0)
subu $v0, $fp, 268
sw $t0, 0($v0)
subu $v0, $fp, 272
sw $t2, 0($v0)
subu $v0, $fp, 276
sw $t3, 0($v0)
subu $v0, $fp, 280
sw $t4, 0($v0)
subu $v0, $fp, 284
sw $t6, 0($v0)
subu $v0, $fp, 288
sw $t8, 0($v0)
j label24
label23:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, -1
li $t3, 4
mul $t2, $t3, $t0
subu $v0, $fp, 44
lw $t5, 0($v0)
add $t4, $t5, $t2
li $t6, 0
sw $t6, 0($t4)
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 44
sw $t5, 0($v0)
subu $v0, $fp, 292
sw $t0, 0($v0)
subu $v0, $fp, 296
sw $t2, 0($v0)
subu $v0, $fp, 300
sw $t3, 0($v0)
subu $v0, $fp, 304
sw $t4, 0($v0)
subu $v0, $fp, 308
sw $t6, 0($v0)
label24:
subu $v0, $fp, 32
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v0, $fp, 220
lw $t2, 0($v0)
move $t2, $t0
subu $v0, $fp, 32
sw $t1, 0($v0)
subu $v0, $fp, 220
sw $t2, 0($v0)
subu $v0, $fp, 312
sw $t0, 0($v0)
label25:
subu $v0, $fp, 220
lw $t0, 0($v0)
li $t1, 0
bgt $t0, $t1, label26
subu $v0, $fp, 220
sw $t0, 0($v0)
subu $v0, $fp, 316
sw $t1, 0($v0)
j label27
label26:
subu $v0, $fp, 220
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 48
lw $t4, 0($v0)
add $t3, $t4, $t0
addi $t5, $t1, -1
li $t7, 4
mul $t6, $t7, $t5
subu $v0, $fp, 24
lw $t9, 0($v0)
move $s0, $t9
add $t8, $s0, $t6
lw $s1, 0($t8)
sw $s1, 0($t3)
addi $s2, $t1, -1
move $t1, $s2
subu $v0, $fp, 24
sw $t9, 0($v0)
subu $v0, $fp, 48
sw $t4, 0($v0)
subu $v0, $fp, 220
sw $t1, 0($v0)
subu $v0, $fp, 320
sw $t0, 0($v0)
subu $v0, $fp, 324
sw $t2, 0($v0)
subu $v0, $fp, 328
sw $t3, 0($v0)
subu $v0, $fp, 332
sw $t5, 0($v0)
subu $v0, $fp, 336
sw $t6, 0($v0)
subu $v0, $fp, 340
sw $t7, 0($v0)
subu $v0, $fp, 344
sw $t8, 0($v0)
subu $v0, $fp, 348
sw $s0, 0($v0)
subu $v0, $fp, 352
sw $s1, 0($v0)
subu $v0, $fp, 356
sw $s2, 0($v0)
j label25
label27:
li $t1, 4
li $t2, 0
mul $t0, $t1, $t2
subu $v0, $fp, 48
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 1
sw $t5, 0($t3)
subu $v0, $fp, 32
lw $t7, 0($v0)
addi $t6, $t7, -1
subu $v1, $fp, 32
sw $t7 ,0($v1)
subu $v1, $fp, 48
sw $t4 ,0($v1)
subu $v1, $fp, 360
sw $t0 ,0($v1)
subu $v1, $fp, 364
sw $t1 ,0($v1)
subu $v1, $fp, 368
sw $t2 ,0($v1)
subu $v1, $fp, 372
sw $t3 ,0($v1)
subu $v1, $fp, 376
sw $t5 ,0($v1)
subu $v1, $fp, 380
sw $t6 ,0($v1)
subu $v0, $fp, 40
lw $t8, 0($v0)
bne $t8, $t6, label28
subu $v0, $fp, 32
sw $t7, 0($v0)
subu $v0, $fp, 40
sw $t8, 0($v0)
subu $v0, $fp, 48
sw $t4, 0($v0)
subu $v0, $fp, 360
sw $t0, 0($v0)
subu $v0, $fp, 364
sw $t1, 0($v0)
subu $v0, $fp, 368
sw $t2, 0($v0)
subu $v0, $fp, 372
sw $t3, 0($v0)
subu $v0, $fp, 376
sw $t5, 0($v0)
subu $v0, $fp, 380
sw $t6, 0($v0)
j label29
label28:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, 1
li $t3, 4
mul $t2, $t3, $t0
subu $v0, $fp, 48
lw $t5, 0($v0)
add $t4, $t5, $t2
li $t6, 0
sw $t6, 0($t4)
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 48
sw $t5, 0($v0)
subu $v0, $fp, 384
sw $t0, 0($v0)
subu $v0, $fp, 388
sw $t2, 0($v0)
subu $v0, $fp, 392
sw $t3, 0($v0)
subu $v0, $fp, 396
sw $t4, 0($v0)
subu $v0, $fp, 400
sw $t6, 0($v0)
label29:
subu $v0, $fp, 28
lw $t1, 0($v0)
addi $t0, $t1, 1
subu $v1, $fp, 28
sw $t1 ,0($v1)
subu $v1, $fp, 404
sw $t0 ,0($v1)
subu $v0, $fp, 12
lw $t2, 0($v0)
move $t3, $t2
move $a0, $t3
subu $v0, $fp, 16
lw $t4, 0($v0)
move $t5, $t4
move $a1, $t5
subu $v0, $fp, 44
lw $t6, 0($v0)
move $a2, $t6
subu $v0, $fp, 48
lw $t7, 0($v0)
move $a3, $t7
subu $sp, 12
sw $t0, 0($sp)
subu $v0, $fp, 32
lw $t8, 0($v0)
sw $t8, 4($sp)
subu $v0, $fp, 36
lw $t9, 0($v0)
move $s0, $t9
sw $s0, 8($sp)
jal dfs
addi $sp, $sp, 12
move $t0, $v0
subu $v0, $fp, 40
lw $t2, 0($v0)
li $t3, 4
mul $t1, $t3, $t2
subu $v0, $fp, 16
lw $t5, 0($v0)
move $t6, $t5
add $t4, $t6, $t1
li $t7, 1
sw $t7, 0($t4)
subu $v0, $fp, 16
sw $t5, 0($v0)
subu $v0, $fp, 40
sw $t2, 0($v0)
subu $v0, $fp, 420
sw $t0, 0($v0)
subu $v0, $fp, 424
sw $t1, 0($v0)
subu $v0, $fp, 428
sw $t3, 0($v0)
subu $v0, $fp, 432
sw $t4, 0($v0)
subu $v0, $fp, 436
sw $t6, 0($v0)
subu $v0, $fp, 440
sw $t7, 0($v0)
label17:
subu $v0, $fp, 40
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 40
sw $t1, 0($v0)
subu $v0, $fp, 444
sw $t0, 0($v0)
j label13
label15:
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
subu $sp, $sp, 576
subu $sp, $sp, 40
move $t0, $sp
subu $sp, $sp, 4
move $t1, $sp
subu $sp, $sp, 40
move $t2, $sp
subu $sp, $sp, 40
move $t3, $sp
subu $sp, $sp, 40
move $t4, $sp
li  $t5, 0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t6, $v0
move $t7, $t6
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
li $t8, 0
beq $t7, $t8, label30
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
j label32
label32:
subu $v0, $fp, 40
lw $t0, 0($v0)
li $t1, 10
bgt $t0, $t1, label30
subu $v0, $fp, 40
sw $t0, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
j label31
label30:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra
label31:
label33:
subu $v0, $fp, 32
lw $t0, 0($v0)
subu $v0, $fp, 40
lw $t1, 0($v0)
blt $t0, $t1, label34
subu $v0, $fp, 32
sw $t0, 0($v0)
subu $v0, $fp, 40
sw $t1, 0($v0)
j label35
label34:
subu $v0, $fp, 32
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 20
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 1
sw $t5, 0($t3)
li $t7, 4
mul $t6, $t7, $t1
subu $v0, $fp, 24
lw $t9, 0($v0)
add $t8, $t9, $t6
li $s0, 1
sw $s0, 0($t8)
li $s2, 4
mul $s1, $s2, $t1
subu $v0, $fp, 28
lw $s4, 0($v0)
add $s3, $s4, $s1
li $s5, 1
sw $s5, 0($s3)
addi $s6, $t1, 1
move $t1, $s6
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t9, 0($v0)
subu $v0, $fp, 28
sw $s4, 0($v0)
subu $v0, $fp, 32
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
subu $v0, $fp, 72
sw $t7, 0($v0)
subu $v0, $fp, 76
sw $t8, 0($v0)
subu $v0, $fp, 80
sw $s0, 0($v0)
subu $v0, $fp, 84
sw $s1, 0($v0)
subu $v0, $fp, 88
sw $s2, 0($v0)
subu $v0, $fp, 92
sw $s3, 0($v0)
subu $v0, $fp, 96
sw $s5, 0($v0)
subu $v0, $fp, 100
sw $s6, 0($v0)
j label33
label35:
li $t1, 4
li $t2, 0
mul $t0, $t1, $t2
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
li $t5, 0
sw $t5, 0($t3)
subu $v1, $fp, 16
sw $t4 ,0($v1)
subu $v1, $fp, 104
sw $t0 ,0($v1)
subu $v1, $fp, 108
sw $t1 ,0($v1)
subu $v1, $fp, 112
sw $t2 ,0($v1)
subu $v1, $fp, 116
sw $t3 ,0($v1)
subu $v1, $fp, 120
sw $t5 ,0($v1)
subu $v0, $fp, 12
lw $t6, 0($v0)
move $a0, $t6
subu $v0, $fp, 20
lw $t7, 0($v0)
move $a1, $t7
subu $v0, $fp, 24
lw $t8, 0($v0)
move $a2, $t8
subu $v0, $fp, 28
lw $t9, 0($v0)
move $a3, $t9
subu $sp, 12
li $s0, 0
sw $s0, 0($sp)
subu $v0, $fp, 40
lw $s1, 0($v0)
sw $s1, 4($sp)
sw $t4, 8($sp)
jal dfs
addi $sp, $sp, 12
move $t0, $v0
li $t2, 4
li $t3, 0
mul $t1, $t2, $t3
subu $v0, $fp, 16
lw $t5, 0($v0)
add $t4, $t5, $t1
lw $t6, 0($t4)
move $a0, $t6
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

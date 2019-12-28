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


trap:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 1500
li  $t0, 0
li  $t1, 0
li  $t2, 0
li  $t3, 0
li  $t4, 0
li  $t5, 12
li  $t6, 0
subu $sp, $sp, 48
move $t7, $sp
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
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 32
lw $t1, 0($v0)
blt $t0, $t1, label1
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
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
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
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
j label0
label2:
subu $v0, $fp, 20
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 20
sw $t0, 0($v0)
label3:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 32
lw $t1, 0($v0)
blt $t0, $t1, label6
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label5
label6:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v1, $fp, 20
sw $t1 ,0($v1)
subu $v1, $fp, 40
sw $t4 ,0($v1)
subu $v1, $fp, 64
sw $t0 ,0($v1)
subu $v1, $fp, 68
sw $t2 ,0($v1)
subu $v1, $fp, 72
sw $t3 ,0($v1)
lw $t5, 0($t3)
li $t6, 0
beq $t5, $t6, label4
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 64
sw $t0, 0($v0)
subu $v0, $fp, 68
sw $t2, 0($v0)
subu $v0, $fp, 72
sw $t3, 0($v0)
subu $v0, $fp, 76
sw $t5, 0($v0)
subu $v0, $fp, 80
sw $t6, 0($v0)
j label5
label4:
subu $v0, $fp, 20
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 84
sw $t0, 0($v0)
j label3
label5:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 32
lw $t1, 0($v0)
bge $t0, $t1, label7
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label8
label7:
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
li $v0, 0
jr $ra
label8:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 12
lw $t5, 0($v0)
lw  $t5, 0($t3)
subu $v0, $fp, 16
lw $t6, 0($v0)
move $t6, $t1
subu $v0, $fp, 28
lw $t7, 0($v0)
li  $t7, 0
addi $t8, $t1, 1
move $t1, $t8
subu $v0, $fp, 12
sw $t5, 0($v0)
subu $v0, $fp, 16
sw $t6, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t7, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 88
sw $t0, 0($v0)
subu $v0, $fp, 92
sw $t2, 0($v0)
subu $v0, $fp, 96
sw $t3, 0($v0)
subu $v0, $fp, 100
sw $t8, 0($v0)
label9:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 32
lw $t1, 0($v0)
blt $t0, $t1, label10
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t1, 0($v0)
j label11
label10:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v1, $fp, 20
sw $t1 ,0($v1)
subu $v1, $fp, 40
sw $t4 ,0($v1)
subu $v1, $fp, 104
sw $t0 ,0($v1)
subu $v1, $fp, 108
sw $t2 ,0($v1)
subu $v1, $fp, 112
sw $t3 ,0($v1)
lw $t5, 0($t3)
subu $v0, $fp, 12
lw $t6, 0($v0)
blt $t5, $t6, label12
subu $v0, $fp, 12
sw $t6, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 104
sw $t0, 0($v0)
subu $v0, $fp, 108
sw $t2, 0($v0)
subu $v0, $fp, 112
sw $t3, 0($v0)
subu $v0, $fp, 116
sw $t5, 0($v0)
j label13
label12:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 12
lw $t6, 0($v0)
lw $t7, 0($t3)
sub $t5, $t6, $t7
subu $v0, $fp, 28
lw $t9, 0($v0)
add $t8, $t9, $t5
move $t9, $t8
subu $v0, $fp, 12
sw $t6, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t9, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 120
sw $t0, 0($v0)
subu $v0, $fp, 124
sw $t2, 0($v0)
subu $v0, $fp, 128
sw $t3, 0($v0)
subu $v0, $fp, 132
sw $t5, 0($v0)
subu $v0, $fp, 136
sw $t7, 0($v0)
subu $v0, $fp, 140
sw $t8, 0($v0)
j label14
label13:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 28
lw $t2, 0($v0)
add $t0, $t1, $t2
move $t1, $t0
subu $v0, $fp, 20
lw $t4, 0($v0)
li $t5, 4
mul $t3, $t5, $t4
subu $v0, $fp, 40
lw $t7, 0($v0)
add $t6, $t7, $t3
subu $v0, $fp, 12
lw $t8, 0($v0)
lw  $t8, 0($t6)
subu $v0, $fp, 16
lw $t9, 0($v0)
move $t9, $t4
li  $t2, 0
subu $v0, $fp, 12
sw $t8, 0($v0)
subu $v0, $fp, 16
sw $t9, 0($v0)
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t2, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
subu $v0, $fp, 144
sw $t0, 0($v0)
subu $v0, $fp, 148
sw $t3, 0($v0)
subu $v0, $fp, 152
sw $t5, 0($v0)
subu $v0, $fp, 156
sw $t6, 0($v0)
label14:
subu $v0, $fp, 20
lw $t1, 0($v0)
addi $t0, $t1, 1
move $t1, $t0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 160
sw $t0, 0($v0)
j label9
label11:
subu $v0, $fp, 28
lw $t0, 0($v0)
li  $t0, 0
subu $v0, $fp, 36
lw $t1, 0($v0)
li  $t1, 0
subu $v0, $fp, 32
lw $t3, 0($v0)
addi $t2, $t3, -1
subu $v0, $fp, 20
lw $t4, 0($v0)
move $t4, $t2
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 28
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t3, 0($v0)
subu $v0, $fp, 36
sw $t1, 0($v0)
subu $v0, $fp, 164
sw $t2, 0($v0)
label15:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
bgt $t0, $t1, label18
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label17
label18:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v1, $fp, 20
sw $t1 ,0($v1)
subu $v1, $fp, 40
sw $t4 ,0($v1)
subu $v1, $fp, 168
sw $t0 ,0($v1)
subu $v1, $fp, 172
sw $t2 ,0($v1)
subu $v1, $fp, 176
sw $t3 ,0($v1)
lw $t5, 0($t3)
li $t6, 0
beq $t5, $t6, label16
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
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
j label17
label16:
subu $v0, $fp, 20
lw $t1, 0($v0)
addi $t0, $t1, -1
move $t1, $t0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 188
sw $t0, 0($v0)
j label15
label17:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 36
lw $t5, 0($v0)
lw  $t5, 0($t3)
addi $t6, $t1, -1
move $t1, $t6
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t5, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 192
sw $t0, 0($v0)
subu $v0, $fp, 196
sw $t2, 0($v0)
subu $v0, $fp, 200
sw $t3, 0($v0)
subu $v0, $fp, 204
sw $t6, 0($v0)
label19:
subu $v0, $fp, 20
lw $t0, 0($v0)
subu $v0, $fp, 16
lw $t1, 0($v0)
bgt $t0, $t1, label20
subu $v0, $fp, 16
sw $t1, 0($v0)
subu $v0, $fp, 20
sw $t0, 0($v0)
j label21
label20:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v1, $fp, 20
sw $t1 ,0($v1)
subu $v1, $fp, 40
sw $t4 ,0($v1)
subu $v1, $fp, 208
sw $t0 ,0($v1)
subu $v1, $fp, 212
sw $t2 ,0($v1)
subu $v1, $fp, 216
sw $t3 ,0($v1)
lw $t5, 0($t3)
subu $v0, $fp, 36
lw $t6, 0($v0)
blt $t5, $t6, label22
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 36
sw $t6, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 208
sw $t0, 0($v0)
subu $v0, $fp, 212
sw $t2, 0($v0)
subu $v0, $fp, 216
sw $t3, 0($v0)
subu $v0, $fp, 220
sw $t5, 0($v0)
j label23
label22:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 40
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v0, $fp, 36
lw $t6, 0($v0)
lw $t7, 0($t3)
sub $t5, $t6, $t7
subu $v0, $fp, 28
lw $t9, 0($v0)
add $t8, $t9, $t5
move $t9, $t8
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t9, 0($v0)
subu $v0, $fp, 36
sw $t6, 0($v0)
subu $v0, $fp, 40
sw $t4, 0($v0)
subu $v0, $fp, 224
sw $t0, 0($v0)
subu $v0, $fp, 228
sw $t2, 0($v0)
subu $v0, $fp, 232
sw $t3, 0($v0)
subu $v0, $fp, 236
sw $t5, 0($v0)
subu $v0, $fp, 240
sw $t7, 0($v0)
subu $v0, $fp, 244
sw $t8, 0($v0)
j label24
label23:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 28
lw $t2, 0($v0)
add $t0, $t1, $t2
move $t1, $t0
subu $v0, $fp, 20
lw $t4, 0($v0)
li $t5, 4
mul $t3, $t5, $t4
subu $v0, $fp, 40
lw $t7, 0($v0)
add $t6, $t7, $t3
subu $v0, $fp, 36
lw $t8, 0($v0)
lw  $t8, 0($t6)
li  $t2, 0
subu $v0, $fp, 20
sw $t4, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t2, 0($v0)
subu $v0, $fp, 36
sw $t8, 0($v0)
subu $v0, $fp, 40
sw $t7, 0($v0)
subu $v0, $fp, 248
sw $t0, 0($v0)
subu $v0, $fp, 252
sw $t3, 0($v0)
subu $v0, $fp, 256
sw $t5, 0($v0)
subu $v0, $fp, 260
sw $t6, 0($v0)
label24:
subu $v0, $fp, 20
lw $t1, 0($v0)
addi $t0, $t1, -1
move $t1, $t0
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 264
sw $t0, 0($v0)
j label19
label21:
subu $v0, $fp, 24
lw $t1, 0($v0)
subu $v0, $fp, 28
lw $t2, 0($v0)
add $t0, $t1, $t2
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $t0
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 48
jal trap
move $t0, $v0
move $t1, $t0
move $a0, $t1
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

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


search:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 1044
move $t0, $a0
subu $sp, $sp, 80
move $t1, $sp
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
li $t1, 5
blt $t0, $t1, label1
subu $v0, $fp, 20
sw $t0, 0($v0)
subu $v0, $fp, 24
sw $t1, 0($v0)
j label2
label1:
subu $v0, $fp, 20
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
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
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 20
sw $t1, 0($v0)
subu $v0, $fp, 28
sw $t0, 0($v0)
subu $v0, $fp, 32
sw $t2, 0($v0)
subu $v0, $fp, 36
sw $t3, 0($v0)
subu $v0, $fp, 40
sw $t5, 0($v0)
subu $v0, $fp, 44
sw $t6, 0($v0)
j label0
label2:
li  $t0, 0
li  $t1, 4
subu $v0, $fp, 48
sw $t0, 0($v0)
subu $v0, $fp, 52
sw $t1, 0($v0)
label3:
subu $v0, $fp, 48
lw $t0, 0($v0)
subu $v0, $fp, 52
lw $t1, 0($v0)
ble $t0, $t1, label4
subu $v0, $fp, 48
sw $t0, 0($v0)
subu $v0, $fp, 52
sw $t1, 0($v0)
j label5
label4:
subu $v0, $fp, 48
lw $t1, 0($v0)
subu $v0, $fp, 52
lw $t2, 0($v0)
add $t0, $t1, $t2
li $t4, 2
div $t0, $t4
mflo $t3
move $t5, $t3
li $t7, 4
mul $t6, $t7, $t5
subu $v0, $fp, 16
lw $t9, 0($v0)
add $t8, $t9, $t6
lw  $s0, 0($t8)
subu $v1, $fp, 16
sw $t9 ,0($v1)
subu $v1, $fp, 48
sw $t1 ,0($v1)
subu $v1, $fp, 52
sw $t2 ,0($v1)
subu $v1, $fp, 56
sw $t0 ,0($v1)
subu $v1, $fp, 60
sw $t3 ,0($v1)
subu $v1, $fp, 64
sw $t4 ,0($v1)
subu $v1, $fp, 68
sw $t5 ,0($v1)
subu $v1, $fp, 72
sw $t6 ,0($v1)
subu $v1, $fp, 76
sw $t7 ,0($v1)
subu $v1, $fp, 80
sw $t8 ,0($v1)
subu $v1, $fp, 84
sw $s0 ,0($v1)
subu $v0, $fp, 12
lw $s1, 0($v0)
beq $s0, $s1, label6
subu $v0, $fp, 12
sw $s1, 0($v0)
subu $v0, $fp, 16
sw $t9, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 52
sw $t2, 0($v0)
subu $v0, $fp, 56
sw $t0, 0($v0)
subu $v0, $fp, 60
sw $t3, 0($v0)
subu $v0, $fp, 64
sw $t4, 0($v0)
subu $v0, $fp, 68
sw $t5, 0($v0)
subu $v0, $fp, 72
sw $t6, 0($v0)
subu $v0, $fp, 76
sw $t7, 0($v0)
subu $v0, $fp, 80
sw $t8, 0($v0)
subu $v0, $fp, 84
sw $s0, 0($v0)
j label7
label6:
subu $v0, $fp, 68
lw $t0, 0($v0)
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $t0
jr $ra
subu $v0, $fp, 68
sw $t0, 0($v0)
label7:
li  $t0, 0
subu $v0, $fp, 48
lw $t2, 0($v0)
li $t3, 4
mul $t1, $t3, $t2
subu $v0, $fp, 16
lw $t5, 0($v0)
add $t4, $t5, $t1
subu $v1, $fp, 16
sw $t5 ,0($v1)
subu $v1, $fp, 48
sw $t2 ,0($v1)
subu $v1, $fp, 88
sw $t0 ,0($v1)
subu $v1, $fp, 92
sw $t1 ,0($v1)
subu $v1, $fp, 96
sw $t3 ,0($v1)
subu $v1, $fp, 100
sw $t4 ,0($v1)
subu $v0, $fp, 84
lw $t6, 0($v0)
lw $t7, 0($t4)
bgt $t6, $t7, label15
subu $v0, $fp, 16
sw $t5, 0($v0)
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 84
sw $t6, 0($v0)
subu $v0, $fp, 88
sw $t0, 0($v0)
subu $v0, $fp, 92
sw $t1, 0($v0)
subu $v0, $fp, 96
sw $t3, 0($v0)
subu $v0, $fp, 100
sw $t4, 0($v0)
subu $v0, $fp, 104
sw $t7, 0($v0)
j label13
label15:
subu $v0, $fp, 48
lw $t1, 0($v0)
li $t2, 4
mul $t0, $t2, $t1
subu $v0, $fp, 16
lw $t4, 0($v0)
add $t3, $t4, $t0
subu $v1, $fp, 16
sw $t4 ,0($v1)
subu $v1, $fp, 48
sw $t1 ,0($v1)
subu $v1, $fp, 108
sw $t0 ,0($v1)
subu $v1, $fp, 112
sw $t2 ,0($v1)
subu $v1, $fp, 116
sw $t3 ,0($v1)
subu $v0, $fp, 12
lw $t5, 0($v0)
lw $t6, 0($t3)
bge $t5, $t6, label14
subu $v0, $fp, 12
sw $t5, 0($v0)
subu $v0, $fp, 16
sw $t4, 0($v0)
subu $v0, $fp, 48
sw $t1, 0($v0)
subu $v0, $fp, 108
sw $t0, 0($v0)
subu $v0, $fp, 112
sw $t2, 0($v0)
subu $v0, $fp, 116
sw $t3, 0($v0)
subu $v0, $fp, 120
sw $t6, 0($v0)
j label13
label14:
subu $v0, $fp, 12
lw $t0, 0($v0)
subu $v0, $fp, 84
lw $t1, 0($v0)
blt $t0, $t1, label12
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 84
sw $t1, 0($v0)
j label13
label12:
subu $v0, $fp, 88
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 88
sw $t0, 0($v0)
label13:
subu $v0, $fp, 88
lw $t0, 0($v0)
li $t1, 0
bne $t0, $t1, label8
subu $v0, $fp, 88
sw $t0, 0($v0)
subu $v0, $fp, 124
sw $t1, 0($v0)
j label11
label11:
li  $t0, 0
subu $v0, $fp, 48
lw $t2, 0($v0)
li $t3, 4
mul $t1, $t3, $t2
subu $v0, $fp, 16
lw $t5, 0($v0)
add $t4, $t5, $t1
subu $v1, $fp, 16
sw $t5 ,0($v1)
subu $v1, $fp, 48
sw $t2 ,0($v1)
subu $v1, $fp, 128
sw $t0 ,0($v1)
subu $v1, $fp, 132
sw $t1 ,0($v1)
subu $v1, $fp, 136
sw $t3 ,0($v1)
subu $v1, $fp, 140
sw $t4 ,0($v1)
subu $v0, $fp, 84
lw $t6, 0($v0)
lw $t7, 0($t4)
blt $t6, $t7, label18
subu $v0, $fp, 16
sw $t5, 0($v0)
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 84
sw $t6, 0($v0)
subu $v0, $fp, 128
sw $t0, 0($v0)
subu $v0, $fp, 132
sw $t1, 0($v0)
subu $v0, $fp, 136
sw $t3, 0($v0)
subu $v0, $fp, 140
sw $t4, 0($v0)
subu $v0, $fp, 144
sw $t7, 0($v0)
j label17
label18:
li  $t0, 0
subu $v0, $fp, 48
lw $t2, 0($v0)
li $t3, 4
mul $t1, $t3, $t2
subu $v0, $fp, 16
lw $t5, 0($v0)
add $t4, $t5, $t1
subu $v1, $fp, 16
sw $t5 ,0($v1)
subu $v1, $fp, 48
sw $t2 ,0($v1)
subu $v1, $fp, 148
sw $t0 ,0($v1)
subu $v1, $fp, 152
sw $t1 ,0($v1)
subu $v1, $fp, 156
sw $t3 ,0($v1)
subu $v1, $fp, 160
sw $t4 ,0($v1)
subu $v0, $fp, 12
lw $t6, 0($v0)
lw $t7, 0($t4)
bge $t6, $t7, label19
subu $v0, $fp, 12
sw $t6, 0($v0)
subu $v0, $fp, 16
sw $t5, 0($v0)
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 148
sw $t0, 0($v0)
subu $v0, $fp, 152
sw $t1, 0($v0)
subu $v0, $fp, 156
sw $t3, 0($v0)
subu $v0, $fp, 160
sw $t4, 0($v0)
subu $v0, $fp, 164
sw $t7, 0($v0)
j label21
label21:
subu $v0, $fp, 12
lw $t0, 0($v0)
subu $v0, $fp, 84
lw $t1, 0($v0)
blt $t0, $t1, label19
subu $v0, $fp, 12
sw $t0, 0($v0)
subu $v0, $fp, 84
sw $t1, 0($v0)
j label20
label19:
subu $v0, $fp, 148
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 148
sw $t0, 0($v0)
label20:
subu $v0, $fp, 148
lw $t0, 0($v0)
li $t1, 0
bne $t0, $t1, label16
subu $v0, $fp, 148
sw $t0, 0($v0)
subu $v0, $fp, 168
sw $t1, 0($v0)
j label17
label16:
subu $v0, $fp, 128
lw $t0, 0($v0)
li  $t0, 1
subu $v0, $fp, 128
sw $t0, 0($v0)
label17:
subu $v0, $fp, 128
lw $t0, 0($v0)
li $t1, 0
bne $t0, $t1, label8
subu $v0, $fp, 128
sw $t0, 0($v0)
subu $v0, $fp, 172
sw $t1, 0($v0)
j label9
label8:
subu $v0, $fp, 68
lw $t1, 0($v0)
addi $t0, $t1, -1
subu $v0, $fp, 52
lw $t2, 0($v0)
move $t2, $t0
subu $v0, $fp, 52
sw $t2, 0($v0)
subu $v0, $fp, 68
sw $t1, 0($v0)
subu $v0, $fp, 176
sw $t0, 0($v0)
j label10
label9:
subu $v0, $fp, 68
lw $t1, 0($v0)
addi $t0, $t1, 1
subu $v0, $fp, 48
lw $t2, 0($v0)
move $t2, $t0
subu $v0, $fp, 48
sw $t2, 0($v0)
subu $v0, $fp, 68
sw $t1, 0($v0)
subu $v0, $fp, 180
sw $t0, 0($v0)
label10:
j label3
label5:
li $t1, 0
addi $t0, $t1, -1
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
subu $sp, $sp, 72
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $t1, $t0
subu $v1, $fp, 12
sw $t0 ,0($v1)
subu $v1, $fp, 16
sw $t1 ,0($v1)
move $a0, $t1
jal search
move $t0, $v0
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

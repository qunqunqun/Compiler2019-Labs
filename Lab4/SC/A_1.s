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
subu $sp, $sp, 300
li  $t0, 3
li  $t1, 12
mul $t2, $t1, $t1
addi $t3, $t2, 13
move $t4, $t3
li $t6, 13
div $t4, $t6
mflo $t5
addi $t7, $t5, 1
move $t8, $t7
div $t1, $t4
mflo $t9
mul $s0, $t4, $t8
add $s1, $t9, $s0
move $s2, $s1
move $a0, $s2
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
li $s4, 2
mul $s3, $s2, $s4
add $s5, $t0, $s3
move $s6, $s5
move $a0, $s6
addi $sp, $sp, -4
sw $ra, 0($sp)
jal write
lw $ra, 0($sp)
addi $sp, $sp, 4
add $s7, $t1, $t4
subu $v0, $fp, 20
sw $t2, 0($v0)
add $t2, $s7, $t8
subu $v0, $fp, 24
sw $t3, 0($v0)
div $t1, $s6
mflo $t3
subu $v0, $fp, 36
sw $t6, 0($v0)
add $t6, $t2, $t3
subu $v0, $fp, 32
sw $t5, 0($v0)
add $t5, $t6, $t0
move $t0, $t5
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

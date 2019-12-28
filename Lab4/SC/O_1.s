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


myadd:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 156
move $t0, $a0
move $t1, $a1
move $t2, $a2
move $t3, $a3
lw $t4, 0($fp)
add $t5, $t0, $t1
add $t6, $t5, $t2
add $t7, $t6, $t3
move $t9, $t4
addi $t8, $t9, 0
lw $s1, 0($t8)
add $s0, $t7, $s1
move $s3, $t4
addi $s2, $s3, 4
lw $s5, 0($s2)
add $s4, $s0, $s5
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $s4
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 168
subu $sp, $sp, 8
move $t0, $sp
addi $t1, $t0, 0
li $t2, 1
sw $t2, 0($t1)
addi $t3, $t0, 4
li $t4, 2
sw $t4, 0($t3)
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
li $t5, 1
move $a0, $t5
li $t6, 1
move $a1, $t6
li $t7, 1
move $a2, $t7
li $t8, 1
move $a3, $t8
subu $sp, 4
sw $t0, 0($sp)
jal myadd
addi $sp, $sp, 4
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

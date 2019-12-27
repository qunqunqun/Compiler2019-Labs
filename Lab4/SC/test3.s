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


fadd:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 60
move $t0, $a0
move $t2, $t0
addi $t1, $t2, 0
move $t4, $t0
addi $t3, $t4, 4
lw $t6, 0($t1)
lw $t7, 0($t3)
add $t5, $t6, $t7
subu $sp, $fp, 8
lw $fp, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4
move $v0, $t5
jr $ra

main:
subu $sp, $sp, 4
sw $ra, 0($sp)
subu $sp, $sp, 4
sw $fp, 0($sp)
addi $fp, $sp, 8
subu $sp, $sp, 120
subu $sp, $sp, 32
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
move $a0, $t0
jal fadd
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

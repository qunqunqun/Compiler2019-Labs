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
syscall
li $v0, 4
la $a0, _ret
syscall
move $v0, $0
jr $ra

main:
li  $t0, 0
li  $t1, 1
li  $t2, 0
addi $sp, $sp, -4
sw $ra, 0($sp)
jal read
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t3, $v0
move  $t4, $t3
label0:
subu $v0, $fp, 12
lw $t5, 0($v0)
subu $v0, $fp, 20
lw $t6, 0($v0)
blt $t5 $t6 label1
j label2
label1:
subu $v0, $fp, 4
lw $t8, 0($v0)
subu $v0, $fp, 8
lw $t9, 0($v0)
add $t7, $t8, $t9
move  $s0, $t7
addi $sp, $sp, -4
sw $ra, 0($sp)
jal wrtie
lw $ra, 0($sp)
addi $sp, $sp, 4
move  $t8, $t9
move  $t9, $s0
subu $v0, $fp, 12
lw $s2, 0($v0)
addi $s1, $s2, 1
move  $s2, $s1
j label0
label2:

#
#	Name: Palmer Du
#	Extra Credit
#	Due: Dec 14
#	Course: CS2640.04-1
# Last Modified: 12/14/22
#
#	Description:
#	  This program prompts users to create an adjecency matrix.
#	  The program first asks users for the number of vertices,
#		and then the connections between them.
#
#		NOTE: 
#		- vertices start from uppercase letter A
#		- please enter connection values as two uppercase 
#		  letters ONLY, for example: XY (for a connection X -> Y)
#		- program will only let you enter two chars for connections
#


	.data
header:	.asciiz	"Diagraph by Palmer Du\n\n"
query:	.asciiz	"Enter number of veritces? "
query2:	.asciiz	"\nEnter connection? "
buf:	.space	8


	.text
main:
	la	$a0, header
	li	$v0, 4
	syscall
	la	$a0, query
	syscall
	li	$v0, 5
	syscall
	move	$s0, $v0		# s0: num vertices
	mul	$s1, $s0, $s0	# s1: matrix size
	move	$a0, $s1
	sll	$a0, $a0, 2
	li	$v0, 9
	syscall
	move	$s2, $v0		# s2: address of matrix
	li	$t0, 0		# t0: count
	li	$t1, 0		# t1: 0
	move	$t2, $s2		# t2: mat
fill:	# initialize matrix with zeros
	beq	$t0, $s1, loop
	sw	$t1, 0($t2)
	addi	$t0, $t0, 1
	addi	$t2, $t2, 4
	b	fill
loop:	# ask user for connections and add them to matrix
	la	$a0, query2
	li	$v0, 4
	syscall
	li	$v0, 8
	la	$a0, buf
	li	$a1, 3
	syscall			#string in buf
	la	$a0, buf
	lb	$t0, ($a0)
	li	$t1, '\n'
	beq	$t0, $t1, end
	la	$t0, buf
	move	$a0, $s2
	lb	$a1, 0($t0)
	sub	$a1, $a1, 65
	lb	$a2, 1($t0)
	sub	$a2, $a2, 65
	jal	addedge
	b	loop

addedge:	# set an edge to 1
	move	$a3, $a0		# a1: row; a2: column; a3: mat pointer
	mul	$a1, $a1, $s0
	sll	$a1, $a1, 2
	add	$a3, $a3, $a1
	sll	$a2, $a2, 2
	add	$a3, $a3, $a2
	li	$t0, 1
	sw	$t0, ($a3)
	jr	$ra

print:	# print matrix
	move	$a2, $a0		# a1: num vertices; a2: mat
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$a0, '*'
	syscall
	li	$a0, ' '
	syscall
	li	$t0, 0		# t0: count
for1:
	beq	$t0, $a1, endfor1
	move	$a0, $t0
	addi	$a0, 65
	li	$v0, 11
	syscall
	li	$a0, ' '
	syscall
	addi	$t0, $t0, 1
	b	for1
endfor1:
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$t0, 0		# t0: row count
for2:
	beq	$t0, $a1, endfor2
	move	$a0, $t0
	addi	$a0, $a0, 65
	li	$v0, 11
	syscall
	li	$a0, ' '
	syscall
	li	$t1, 0		# t1: coulumn count
for3:
	beq	$t1, $a1, endfor3
	lw	$a0, 0($a2)
	li	$v0, 1
	syscall
	li	$a0, ' '
	li	$v0, 11
	syscall
	addi	$a2, $a2, 4
	addi	$t1, $t1, 1
	b	for3
endfor3:
	li	$a0, '\n'
	li	$v0, 11
	syscall
	addi	$t0, $t0, 1
	b	for2
endfor2:
	jr	$ra

end:
	move	$a0, $s2
	move	$a1, $s0
	jal	print
	li	$v0, 10

syscall

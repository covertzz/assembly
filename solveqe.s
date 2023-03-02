#
#	Name: Palmer Du
#	Project: 5
#	Due: Dec 8
#	Course: CS2640.04-1
#	Last Modified: 12/5/22
#	Description:
#		This program asks the user for the coefficients
#		of a quadratic equation and returns the roots
#		if it is a valid equation. Linear equations
#		will return a single root, and if the equation
#		is invalid or is imaginary, then the program
#		will notify the user.
#
#		This program also uses a custom square root
#		function (extra credit)
#
	.data
header:	.asciiz	"Quadratic Equation Solver v0.1 by P. Du\n(extra credit square root operation COMPLETE)"
aye:	.asciiz	"Enter value for a? "
bee:	.asciiz	"Enter value for b? "
cee:	.asciiz	"Enter value for c? "
xsquare:	.asciiz	" x^2 + "
xplus:	.asciiz	" x + "
eq0:	.asciiz	" = 0\n"
notq:	.asciiz	"Not a quadratic equation."
i:	.asciiz	"Roots are imaginary."
x:	.asciiz	"x = "
x1:	.asciiz	"x1 = "
x2:	.asciiz	"\nx2 = "


	.text
main:
	la	$a0, header
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	syscall
	la	$a0, aye
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	mov.s	$f15, $f0
	li	$a0, '\n'
	li	$v0, 11
	syscall
	la	$a0, bee
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	mov.s	$f13, $f0		# f13: b
	li	$a0, '\n'
	li	$v0, 11
	syscall
	la	$a0, cee
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	mov.s	$f14, $f0		# f14: c
	mov.s	$f12, $f15
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$v0, 2
	syscall
	la	$a0, xsquare
	li	$v0, 4
	syscall
	mov.s	$f12, $f13
	li	$v0, 2
	syscall
	la	$a0, xplus
	li	$v0,4
	syscall
	mov.s	$f12, $f14
	li	$v0, 2
	syscall
	la	$a0, eq0
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	mov.s	$f12, $f15	# f12: a
	jal	quadeq
	bltz	$v0, image
	beqz	$v0, notquad
	li	$t1, 1
	beq	$v0, $t1, lin
	la	$a0, x1
	li	$v0, 4
	syscall
	mov.s	$f12, $f0
	li	$v0, 2
	syscall
	la	$a0, x2
	li	$v0, 4
	syscall
	mov.s	$f12, $f1
	li	$v0, 2
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	b	end
image:
	la	$a0, i
	li	$v0, 4
	syscall
	b	end
notquad:
	la	$a0, notq
	li	$v0, 4
	syscall
	b	end
lin:
	la	$a0, x
	li	$v0, 4
	syscall
	mov.s	$f12, $f0
	li	$v0, 2
	syscall
	b	end


quadeq:
	li.s	$f0, 0.0
	c.eq.s	$f12, $f0
	bc1t	az
	b	disc
az:				# if a == 0
	c.eq.s	$f13, $f0
	bc1t	bz
	div.s	$f0, $f14, $f13
	li.s	$f1, 0.0
	c.eq.s	$f14, $f1
	bc1t	cz
	li.s	$f1, -1.0
	mul.s	$f0, $f0, $f1
cz:	li	$v0, 1
	jr	$ra
bz:				# if b == 0
	li	$v0, 0
	jr	$ra
disc:
	mul.s	$f4, $f13, $f13
	mul.s	$f5, $f12, $f14
	li.s	$f6, 4.0
	mul.s	$f5, $f5, $f6
	sub.s	$f4, $f4, $f5	# f4: discriminant 
	li.s	$f5, 0.0
	c.lt.s	$f4, $f5
	bc1f	else
	li	$v0, -1
	jr	$ra
else:	# (-b +- sqrt(disc)) / 2a
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	s.s	$f12, 4($sp)
	s.s	$f4, 8($sp)
	mov.s	$f12, $f4
	jal	root
	l.s	$f12, 4($sp)
	l.s	$f4, 8($sp)
	mov.s	$f4, $f0		# f4: sqrt(disc)
	li.s	$f5, -1.0
	mul.s	$f13, $f13, $f5	# f13: -b
	li.s	$f6, 2.0
	mul.s	$f12, $f12, $f6	# f12: 2a
	add.s	$f0, $f13, $f4
	div.s	$f0, $f0, $f12	# f0: (-b + sqrt(disc)) / 2a
	sub.s	$f1, $f13, $f4
	div.s	$f1, $f1, $f12	# f1: (-b - sqrt(disc)) / 2a
	li	$v0, 2
	lw	$ra, 0($sp)
	addi	$sp, $sp, 12
	jr	$ra

root:
	li.s	$f4, 0.0000001	# f4: err
	mov.s	$f0, $f12		# f0: t
while:
	div.s	$f5, $f12, $f0	# f5: c/t
	sub.s	$f6, $f0, $f5	# $f6: check 1
	abs.s	$f6, $f6
	mul.s	$f7, $f4, $f0
	c.lt.s	$f7, $f6
	bc1f	endWhile
	add.s	$f0, $f5, $f0
	li.s	$f5, 2.0
	div.s	$f0, $f0, $f5
	b	while
endWhile:
	jr	$ra

end:
	li	$v0, 10
	syscall

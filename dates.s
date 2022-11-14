#
#	Name: Palmer Du
#	Course: CS2640 (Computer Organization and Assembly Programming)
#
#	Description:
#		Quick MIPS program that takes in a 
#		specified date and determines if it
#		is a leap year, and what day of the 
#		week it falls on.
#
	.data
header:	.asciiz	"Dates.s by P. Du"
month:	.asciiz	"Enter the month: "
day:	.asciiz	"Enter the day: "
year:	.asciiz	"Enter the year: "
isNot:	.asciiz	" is not a "
isA:	.asciiz	" is a "
leap:	.asciiz	"leap year and "
mon:	.asciiz	"Monday"
tue:	.asciiz	"Tuesday"
wed:	.asciiz	"Wednesday"
thu:	.asciiz	"Thursday"
fri:	.asciiz	"Friday"
sat:	.asciiz	"Saturday"
sun:	.asciiz	"Sunday"

	.text
main:
	la	$a0, header
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$a0, '\n'
	syscall
	la	$a0, month
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$t0, $v0		# $t0=month
	la	$a0, day
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$t1, $v0		# $t1=day
	la	$a0, year
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$t2, $v0		# $t2=year
	li	$a0, '\n'
	li	$v0, 11
	syscall
	move	$a0, $t2
	li	$v0, 1
	syscall
leapYear:
	rem	$t3, $t2, 4
	bnez	$t3, maybeLeap
	rem	$t3, $t2, 100
	beqz	$t3, maybeLeap
	b	aLeap
maybeLeap:
	rem	$t3, $t2, 400
	bnez	$t3, notLeap
	b	aLeap
aLeap:
	la	$a0, isA
	li	$v0, 4
	syscall
	la	$a0, leap
	syscall
	b	endif
notLeap:
	la	$a0, isNot
	li	$v0, 4
	syscall
	la	$a0, leap
	syscall
	b	endif
endif:
	li	$t3, 14
	sub	$t4, $t3, $t0
	div	$t4, $t4, 12	# $t4=a
	sub	$t5, $t2, $t4	# $t5=y
	sub	$t3, $t0, 2
	mul	$t6, $t4, 12
	add	$t6, $t6, $t3	# $t6=m
	add	$t7, $t1, $t5	# $t7=d
	div	$t3, $t5, 4
	add	$t7, $t7, $t3
	div	$t3, $t5, 100
	sub	$t7, $t7, $t3
	div	$t3, $t5, 400
	add	$t7, $t7, $t3
	mul	$t3, $t6, 31
	div	$t3, $t3, 12
	add	$t7, $t7, $t3
	rem	$t7, $t7, 7
	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$a0, '/'
	li	$v0, 11
	syscall
	move	$a0, $t1
	li	$v0, 1
	syscall
	li	$a0, '/'
	li	$v0, 11
	syscall
	move	$a0, $t2
	li	$v0, 1
	syscall			#print full date
	la	$a0, isA
	li	$v0, 4
	syscall
	beq	$t7, $zero, sunday
	beq	$t7, 1, monday
	beq	$t7, 2, tuesday
	beq	$t7, 3, wednesday
	beq	$t7, 4, thursday
	beq	$t7, 5, friday
saturday:
	la	$a0, sat
	li	$v0, 4
	syscall
	b	end
sunday:
	la	$a0, sun
	li	$v0, 4
	syscall
	b	end
monday:
	la	$a0, mon
	li	$v0, 4
	syscall
	b	end
tuesday:
	la	$a0, tue
	li	$v0, 4
	syscall
	b	end
wednesday:
	la	$a0, wed
	li	$v0, 4
	syscall
	b	end
thursday:
	la	$a0, thu
	li	$v0, 4
	syscall
	b	end
friday:
	la	$a0, fri
	li	$v0, 4
	syscall
	b	end
end:
	li	$v0, 10
	syscall

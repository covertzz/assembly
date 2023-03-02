#
#	Name: Palmer Du
#	Homework: 4
#	Due: Nov 10
#	Course: CS2640.04-1
#	Last Modified: 11/10/22
#
#	Description:
#		this program checks to see if a given word is a java
#		keyword. It takes in various inputs from the command 
#		line and runs a string comparision by searching through
#		an array of keywords.
#
	.data
header:	.asciiz	"Java Keywords by P. Du"
keywords:
	.word	abstract, assert, boolean, xbreak, byte, case, catch, char
	.word	class, const, continue, default, xdo, double, else, enum
	.word	extends, false, final, finally, float, for, goto, if
	.word	implements, import, instanceof, int, interface, long, native, new
	.word	null, package, private, protected, public, return, short, static
	.word	strictfp, super, switch, synchronized, this, throw, throws, transient
	.word	true, try, void, volatile, xwhile

abstract:	.asciiz	"abstract"
assert:	.asciiz	"assert"
boolean:	.asciiz	"boolean"
xbreak:	.asciiz	"break"
byte:	.asciiz	"byte"
case:	.asciiz	"case"
catch:	.asciiz	"catch"
char:	.asciiz	"char"
class:	.asciiz	"class"
const:	.asciiz	"const"
continue:	.asciiz	"continue"
default:	.asciiz	"default"
xdo:	.asciiz	"do"
double:	.asciiz	"double"
else:	.asciiz	"else"
enum:	.asciiz	"enum"
extends:	.asciiz	"extends"
false:	.asciiz	"false"
final:	.asciiz	"final"
finally:	.asciiz	"finally"
float:	.asciiz	"float"
for:	.asciiz	"for"
goto:	.asciiz	"goto"
if:	.asciiz	"if"
implements:	.asciiz	"implements"
import:	.asciiz	"import"
instanceof:
	.asciiz	"instanceof"
int:	.asciiz	"int"
interface:
	.asciiz	"interface"
long:	.asciiz	"long"
native:	.asciiz	"native"
new:	.asciiz	"new"
null:	.asciiz	"null"
package:	.asciiz	"package"
private:	.asciiz	"private"
protected:
	.asciiz	"protected"
public:	.asciiz	"public"
return:	.asciiz	"return"
short:	.asciiz	"short"
static:	.asciiz	"static"
strictfp:	.asciiz	"strictfp"
super:	.asciiz	"super"
switch:	.asciiz	"switch"
synchronized:
	.asciiz	"synchronized"
this:	.asciiz	"this"
throw:	.asciiz	"throw"
throws:	.asciiz	"throws"
transient:
	.asciiz	"transient"
true:	.asciiz	"true"
try:	.asciiz	"try"
void:	.asciiz	"void"
volatile:	.asciiz	"volatile"
xwhile:	.asciiz	"while"

	.text
main:
	move	$s1, $a0		# $s1 = num inputs
	sub	$s1, $s1, 1
	move	$s2, $a1		# $s2 = inputs
	la	$a0, header
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	li	$a0, '\n'
	syscall
	li	$t7, 0		# $t7 = count
while:
	beqz	$s1, end
	addi	$s2, $s2, 4
	lw	$a2, ($s2)	# $a2 = string
	la	$a0, keywords	# $a0 = keywords
	li	$a1, 53		# $a1 = len
	jal	lsearch
	
	bge	$v0, 53, one
	move	$t4, $v0
	sll	$t0, $v0, 2
	la	$a0, keywords
	add	$t1, $t0, $a0
	lw	$a0, ($t1)	# loop and output all argv
	li	$v0, 4
	syscall
	li	$a0, ':'
	li	$v0, 11
	syscall
	move	$a0, $t4
	li	$v0, 1
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	b	two
one:
	lw	$a0, ($s2)
	li	$v0, 4
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
two:	sub	$s1, $s1, 1
	li	$t3, 53
	sub	$v0, $t3, $t1
	b	while

lsearch:			# a0: keywords, a1: length, a2: string
	move	$t0, $a0
	move	$t1, $a1
	move	$t2, $a2
	li	$t3, 0		# $t3 = i
do:	beqz	$t1, dont
	lw	$a0, ($t0)	# loop and output all argv
	lw	$a0, ($t0)
	move	$a2, $t2
	addiu	$sp, $sp, -16
	sw	$ra, ($sp)
	sw	$t0, 4($sp)
	sw	$t1, 8($sp)
	sw	$t2, 12($sp)
	jal	strcmp
	lw	$ra, ($sp)
	lw	$t0, 4($sp)
	lw	$t1, 8($sp)
	lw	$t2, 12($sp)
	addi	$sp, $sp, 16
	addi	$t0, $t0, 4
	sub	$t1, $t1, 1
	bnez	$v0, don
	b	dont
don:
	addi	$t3, $t3, 1
	b	do
dont:
	move	$v0, $t3
	jr	$ra

strcmp:			# a0: string 1, a2: string 2
	lb	$t0, ($a0)
	lb	$t1, ($a2)
	bne	$t1, $t0, neq
	beqz	$t0, eq
	addi	$a0, $a0, 1
	addi	$a2, $a2, 1
	b	strcmp
neq:
	sub	$v0, $t0, $t1
	jr	$ra
eq:
	li	$v0, 0
	jr	$ra
end:
	li	$v0, 10
	syscall

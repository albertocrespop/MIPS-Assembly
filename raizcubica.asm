	.data
pedirnum:
	.asciiz		"Introduce un número: "
	.text
cubo:				# $a0 = entero como parámetro
	li	$t0, 0
	move	$t1, $a0
c_for:
	bge	$t0,2,c_finfor	# Condición (i < 2)
	mul	$t1,$t1,$a0
	addiu	$t0, $t0, 1	# i++
	j	c_for
c_finfor:
	move	$v0, $t1
	jr	$ra
raizcubica:			
	addiu	$sp, $sp, -16
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$ra, 12($sp)
	
	move	$s0, $a0	# n = $s0
	li	$s1, 0		# r = $s1
	move	$a0, $s1
	jal	cubo
	move	$s2, $v0	# potencia = $s2
rc_while:
	bge 	$s2,$s0,rc_finwhile
	addiu	$s1, $s1, 1
	move	$a0, $s1
	jal	cubo
	move	$s2, $v0
	j	rc_while
rc_finwhile:
	ble 	$s2,$s0,rc_finif
	addiu	$v0, $s1, -1
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$ra, 12($sp)
	addiu	$sp, $sp, 16
	
	jr	$ra
rc_finif:
	move	$v0, $s1
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$ra, 12($sp)
	addiu	$sp, $sp, 16
	
	jr	$ra
	
mostrar_cadena:			# $a0 = dirección de cadena
	li	$v0, 4
	syscall
	jr	$ra
mostrar_numero:			# $a0 = entero por mostrar
	li	$v0, 1
	syscall
	jr	$ra
pedir_numero:			# $a0 = direccion de cadena
	addiu	$sp, $sp, -4	# Apila $ra
	sw	$ra, 0($sp)
	
	jal	mostrar_cadena
	
	li	$v0, 5
	syscall
	
	lw	$ra, 0($sp)	# Desapila
	addiu	$sp, $sp, 4
	
	jr	$ra
	.globl main
main:
	la	$a0, pedirnum
	jal	pedir_numero
	move	$a0, $v0
	jal	raizcubica
	move	$a0, $v0
	jal	mostrar_numero
	
	li	$v0, 10
	syscall
	jr	$ra
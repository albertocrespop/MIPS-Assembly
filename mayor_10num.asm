	.data
dospuntos:	
	.asciiz		": "
mostrarmayor:
	.asciiz		"\nEl número mayor es: "
	.text
mayor:				# $a0, $a1 - Entero a y b
	bgt 	$a0,$a1,a0
	move	$v0, $a1
	jr	$ra
a0:	
	move	$v0, $a0
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
	addiu	$sp, $sp, -16
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$ra, 12($sp)
	
	li	$s0, 1		# $s0 = i
	
	move	$a0, $s0
	jal	mostrar_numero
	la	$a0, dospuntos
	jal	pedir_numero
	move	$s1, $v0	# $s1 = mayor
	
	addiu	$s0, $s0, 1
bucle:
	bgt	$s0,10,finbucle
	move	$a0, $s0
	jal	mostrar_numero
	la	$a0, dospuntos
	jal	pedir_numero
	move	$s2, $v0	# $s2 = comparar
	
	move	$a0, $s1
	move	$a1, $s2
	jal	mayor
	move	$s1, $v0
	
	addiu	$s0, $s0, 1

	j	bucle
finbucle:
	la	$a0, mostrarmayor
	li	$v0, 4
	syscall
	
	li	$v0, 1
	move	$a0, $s1
	syscall

	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$ra, 12($sp)
	li	$v0, 10
	syscall
	jr	$ra

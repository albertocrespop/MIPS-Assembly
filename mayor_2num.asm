	.data
pedirnuma:	.asciiz "Introduce el primer número: "
pedirnumb:	.asciiz "Introduce el segundo número: "
mostrarnum:	.asciiz "El número mayor es: "
adios:		.asciiz "¡Adiós!"
jump:		.asciiz "\n"
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
pedir_numero:			# $a0 = direccion de cadena "pedirnumx"
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
	addiu	$sp, $sp, -12	# Apila $s0
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
bucle:
	la	$a0, pedirnuma	# Pide numero a
	jal	pedir_numero
	move	$s0, $v0
	
	la	$a0, pedirnumb	# Pide numero b
	jal	pedir_numero
	move	$s1, $v0

	beq	$s0,$s1,iguales
	
	move	$a0, $s0	# Paso de parámetros para la función
	move 	$a1, $s1	
	jal	mayor		# Llamada de la función	"mayor"
	
	move	$s2, $v0	# Guarda el mayor en $s2
	
	la	$a0,mostrarnum
	jal	mostrar_cadena	# Llamada de la función "mostrar_cadena"
	
	move	$a0, $s2
	jal	mostrar_numero	# Llamada de la función "mostrar_numero"
	
	la	$a0,jump
	jal	mostrar_cadena	# Llamada de la función "mostrar_cadena"
	
	j	bucle
	
iguales:
	la	$a0, adios
	jal	mostrar_cadena
	
	lw	$s0, 0($sp)	# Desapila $s0
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)	
	addiu	$sp, $sp, 12	
	
	li	$v0, 10
	syscall
	jr	$ra
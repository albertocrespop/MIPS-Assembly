	.data
pedirnuma:
	.asciiz		"Introduce el primer número: "
pedirnumb:
	.asciiz		"Introduce el segundo número: "
mcm:	
	.asciiz		"\nEl MCM de "
mcm1:	
	.asciiz		" y "
mcm2:	
	.asciiz		" es: "
	.text
minimocomunmultiplo:		# $a0, $a1 - Entero x e y
	addiu	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$ra, 8($sp)
			
	move	$s0, $a0	# x = $s0
	move	$s1, $a1	# y = $s1
	jal	mayor
	move	$t0,$v0		# mcm = $t0
	mul	$t1,$s0,$s1	# Limite = $t1 
	li	$t2, 0		# Salir = $t2
while:	
	bnez 	$t2,mcm_finwhile
	bge 	$t0,$t1,mcm_finwhile
	rem	$t3, $t0, $s0
	beqz 	$t3,mcm_finif
	addiu	$t0, $t0, 1
	j	while
mcm_finif:
	rem	$t3, $t0, $s1
	beqz 	$t3,mcm_finelse
	addiu	$t0, $t0, 1
	j	while
mcm_finelse:
	li	$t2, 1
	j 	while
mcm_finwhile:
	move	$v0, $t0
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addiu	$sp, $sp, 12
	
	jr	$ra
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
	addiu	$sp, $sp, -12
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	
	la	$a0, pedirnuma
	jal	pedir_numero
	move	$s0, $v0		# 1 num = $s0
	
	la	$a0, pedirnumb
	jal	pedir_numero
	move	$s1, $v0		# 2 num = $s1
	
	move	$a0, $s0
	move	$a1, $s1
	jal	minimocomunmultiplo
	
	move	$s2, $v0		# MCM = $s2
	la	$a0, mcm
	jal 	mostrar_cadena
	move	$a0, $s0
	jal	mostrar_numero
	la	$a0, mcm1
	jal 	mostrar_cadena
	move	$a0, $s1
	jal	mostrar_numero
	la	$a0, mcm2
	jal 	mostrar_cadena
	move	$a0, $s2
	jal	mostrar_numero
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	addiu	$sp, $sp, 8
	
	li	$v0, 10
	syscall
	jr	$ra
	
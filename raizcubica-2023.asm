	.data
pedir:	.asciiz	"Introduce un número: "
resul:	.asciiz "La parte entera de la raíz cúbica del número introducido es: "
	.text
	.globl	main
cubo:		# $a0: número a elevar
	mul	$v0, $a0, $a0
	mul	$v0, $v0, $a0
	jr	$ra

raizcubica:	# $a0: número cuya raíz cúbica he de calcular
	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)k
	
	move	$s0, $a0	# $s0 = n
	li	$s1, 0		# $s1 = r
	move	$a0, $s1
	jal	cubo
	move	$s2, $v0	# $s2 = potencia
rc_while:
	bge	$s2, $s0, rc_finwhile
	addiu	$s1, $s1, 1	# r++
	move	$a0, $s1
	jal	cubo
	move	$s2, $v0
	j	rc_while
rc_finwhile:
	ble	$s2, $s0, rc_finif
	addiu	$v0, $s1, -1

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra
rc_finif:
	move	$v0, $s1
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra

mostrar_cadena:
	#move	$a0, $a0
	li	$v0, 4
	syscall
	jr	$ra

mostrar_numero:
	#move	$a0, $a0
	li	$v0, 1
	syscall
	jr	$ra

pedir_numero:		# $a0: cadena para pedir número
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	move	$a0, $a0
	jal	mostrar_cadena
	
	li	$v0, 5
	syscall
	move	$v0, $v0
	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra

main:
	addiu	$sp, $sp, -8
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	
	la	$a0, pedir
	jal	pedir_numero	# v0: número introducido
	move	$a0, $v0
	jal	raizcubica	# v0: parte entera de la raiz cúbica
	move	$s0, $v0
	la	$a0, resul	
	jal	mostrar_cadena
	move	$a0, $s0
	jal	mostrar_numero
	
	li	$v0, 10
	syscall			# exit

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	addiu	$sp, $sp, 8
	jr	$ra

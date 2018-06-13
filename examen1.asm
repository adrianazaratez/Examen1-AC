
.data
	V: .word 1 2 3
	M: .word 1 2 3 4 5 6 7 8 9
	R: .word 0 0 0

.text

Main:
	la $s0,V
	la $s1,M
	la $s2,R
	
	addi $s7,$zero,1
	addi $s6,$zero,4
	addi $s3,$zero,3 #Num de columnas de M
	addi $s4,$zero,0 #s4 = i;
	addi $s5,$zero,0 #s5 = j;
	 
ForI:	beq $s4,$s3,Exit
ForJ:	beq $s5,$s3,Next
	lw $t0,0($s0)	#Obtenemos V[j]
	jal GetM
	lw $t2,0($s2)	#Obtenemos R[i]
	mult $t0,$v0	#V * M
	mflo $t3
	add $t4,$t2,$t3 # R + (V * M)
	sw $t4,0($s2)
	addi $s5,$s5,1
	addi $s0,$s0,4
	j ForJ

Next:	addi $s4,$s4,1
	addi $s2,$s2,4
	la $s0,V
	addi $s5,$zero,0
	j ForI
	
	
GetM:	beq $s4,$zero,IisZero
	beq $s4,$s7,IisOne
IisTwo: addi $t7,$zero,4
	add $t6,$s5,$t7
	addi $t6,$t6,2
	mult $t6,$s6
	mflo $t6
	add $t6,$t6,$s1
	lw $v0,0($t6)
	jr $ra
	
IisZero:
	add $t6,$zero,$s5
	mult $t6,$s6
	mflo $t6
	add $t6,$t6,$s1
	lw $v0,0($t6)	#Obtenemos M
	jr $ra

IisOne: addi $t7,$zero,2
	add $t6,$s5,$t7
	addi $t6,$t6,1
	mult $t6,$s6
	mflo $t6
	add $t6,$t6,$s1
	lw $v0,0($t6)
	jr $ra
	
Exit:
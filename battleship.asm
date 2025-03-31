.data
	matrixA: 		.space 196
    	matrixB: 		.space 196
    	str_welcome:		.asciiz "\nWelcome to the Battleship game!\n"
    	str_line:		.asciiz "=================================\n"
    	str_space: 		.asciiz " "
    	str_endl: 		.asciiz "\n"
    	str_input_matrixA: 	.asciiz "Player A enter coordinates for ships.\n"
    	str_input_matrixB: 	.asciiz "Player B enter coordinates for ships.\n"
    	str_enter_2x1: 		.asciiz "Enter coordinates of 2x1 ship: \n"
    	str_enter_3x1: 		.asciiz "Enter coordinates of 3x1 ship: \n"
    	str_enter_4x1: 		.asciiz "Enter coordinates of 4x1 ship: \n"
    	str_A_attack: 		.asciiz "Player A attack: \n"
    	str_B_attack: 		.asciiz "Player B attack: \n"
    	str_hit: 		.asciiz "HIT!\n"
    	str_not_hit:		.asciiz "MISS!\n"
    	str_A_win:		.asciiz "Player A win!\n"
    	str_B_win:		.asciiz "Player B win!\n"
    	str_countA:		.asciiz "Counting variable of player A: "
    	str_countB:		.asciiz "Counting variable of player B: "
    	str_invalidInput:	.asciiz "Invalid input. Please enter again.\n"
    	
.text
main:
	# Welcome and instruction
	li $v0, 4
	la $a0, str_welcome
	syscall
	li $v0, 4
	la $a0, str_line
	syscall
    	# Initialize matrix
    	jal init_matrixA
    	jal init_matrixB
	# Start game
    	j startgame
    	
######### Initialize matrix #########
init_matrixA:
	la $a1, matrixA
	li $s1, 0 # count for cells number 1 in matrixA
	li $t0, 0 # index = 0
    	initA:
        	sb $zero, ($a1)  # Store 0 to matrixA[i]
        	addi $a1, $a1, 1 # Increment address
        	addi $t0, $t0, 1 # Increment index
        	bne $t0, 49, initA
    	jr $ra	
init_matrixB:
    	la $a2, matrixB
    	li $s2, 0 # count for cells number 1 in matrixB
    	li $t0, 0 # index = 0
    	initB:
        	sb $zero, ($a2)  # Store 0 to matrixB[i]
        	addi $a2, $a2, 1 # Increment address
        	addi $t0, $t0, 1 # Increment index
        	bne $t0, 49, initB
    	jr $ra
    	
######### Start game #########
startgame:
	inputCoordinateA:
		li $v0, 4
		la $a0, str_input_matrixA
		syscall
		li $s5, 0 # temp variable for branching
		move $t8, $a1
		move $t9, $s1
		j input2x1
	inputCoordinateB:
		li $v0, 4
		la $a0, str_input_matrixB
		syscall
		addi $s5, $s5, 1
		move $t8, $a2
		move $t9, $s2
		j input2x1
### Input Coordinate ###
input2x1:
	li $t7, 0 # count variable for loop
	loop2x1:
		# Display
		li $v0, 4
		la $a0, str_enter_2x1
		syscall
		# Input row bow
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t3, $v0
    		# Input col bow
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t4, $v0
    		# Input row stern
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t5, $v0
    		# Input col stern
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t6, $v0
    		# Valid size?
    		jal validSize
    		# Fill ship	
    		jal fillShip
    		addi $t9, $t9, 2
    		# Update
    		addi $t7, $t7, 1
    		bne $t7, 3, loop2x1
    	# Print for check
    	move $s0, $t8
    	jal printMatrix
    	li $v0, 4
    	la $a0, str_endl
    	syscall
    	j input3x1
input3x1:
	li $t7, 0 # count variable for loop
	loop3x1:
		# Display
		li $v0, 4
		la $a0, str_enter_3x1
		syscall
		# Input row bow
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t3, $v0
    		# Input col bow
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t4, $v0
    		# Input row stern
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t5, $v0
    		# Input col stern
		li $v0, 5 
    		syscall
    		move $s7, $v0
    		jal validIndex
    		move $t6, $v0
    		# Valid size?
    		jal validSize
    		# Fill ship	
    		jal fillShip
    		addi $t9, $t9, 3
    		# Update
    		addi $t7, $t7, 1
    		bne $t7, 2, loop3x1
    	# Print for check
    	move $s0, $t8
    	jal printMatrix
    	li $v0, 4
    	la $a0, str_endl
    	syscall
	j input4x1
input4x1:
	# Display
	li $v0, 4
	la $a0, str_enter_4x1
	syscall
	# Input row bow
	li $v0, 5 
    	syscall
    	move $s7, $v0
    	jal validIndex
    	move $t3, $v0
    	# Input col bow
	li $v0, 5 
    	syscall
    	move $s7, $v0
    	jal validIndex
    	move $t4, $v0
    	# Input row stern
	li $v0, 5 
    	syscall
    	move $s7, $v0
    	jal validIndex
    	move $t5, $v0
    	# Input col stern
	li $v0, 5 
    	syscall
    	move $s7, $v0
    	jal validIndex
    	move $t6, $v0
    	# Valid size?
    	jal validSize
	# Fill ship	
    	jal fillShip
    	addi $t9, $t9, 4
    	# Print for check
    	move $s0, $t8
    	jal printMatrix
    	li $v0, 4
    	la $a0, str_endl
    	syscall
    	# Branching
    	beq $s5, 0, nextInputB
    	j nextInGame
    	nextInputB:
    		move $s1, $t9
    		j inputCoordinateB
    	nextInGame:
    		move $s2, $t9
    		j inGame
fillShip:
	li $t1, 1
	move $k0, $t3
	move $k1, $t5
	# Position of bow
	mul $t3, $t3, 7
	add $t3, $t3, $t4
	# Position of stern
	mul $t5, $t5, 7
	add $t5, $t5, $t6
	# Swap t3 and t5 if t5 < t3
	slt $s6, $t5, $t3
	beq $s6, 1, swap
	j branchForFill
	swap:
		move $s7, $t3
		move $t3, $t5
		move $t5, $s7
	# Branch for fill
	branchForFill:
		bne $k0, $k1, fillVertical
		j fillHorizontal
	fillVertical:
		VerticalLoop:
			# Update value
			add $t2, $t8, $t3
			# Overlap?
			lb $v1, 0($t2)
			beq $v1, 1, invalidInput
			# Fill
			sb $t1, 0($t2)
			addi $t3, $t3, 7
			ble  $t3, $t5, VerticalLoop
		jr $ra
	fillHorizontal:
		HorizontalLoop:
			# Update value
			add $t2, $t8, $t3
			# Overlap?
			lb $v1, 0($t2)
			beq $v1, 1, invalidInput
			# Fill
			sb $t1, 0($t2)
			addi $t3, $t3, 1
			ble $t3, $t5, HorizontalLoop
		jr $ra
### In game ###
inGame:
	playerAattack:
		# Display
		li $v0, 4
		la $a0, str_A_attack
		syscall
		# Attack
		li $s5, 0
		move $s3, $a2 # matrixB
		move $s4, $s2 # countB
		j attack
	playerBattack:
		# Display
		li $v0, 4
		la $a0, str_B_attack
		syscall
		# Attack
		li $s5, 1
		move $s3, $a1 # matrixA
		move $s4, $s1 # countA
		j attack
attack:
	# Input row
	li $v0, 5 
    	syscall
    	# Valid index?
   	move $s7, $v0
   	jal validAttack
   	move $t3, $v0
    	# Input column
	li $v0, 5 
    	syscall
    	# Valid index?
   	move $s7, $v0
   	jal validAttack
    	move $t4, $v0 
    	# Get position
    	mul $t3, $t3, 7
	add $t3, $t3, $t4
	# Get value
	add $t2, $s3, $t3
	lb $a3, 0($t2)
	# Hit or not?
	beq $a3, 1, hit
	j notHit
	hit:
		# Print "HIT!"
		li $v0, 4
		la $a0, str_hit
		syscall
		# 1 -> 0
		sb $zero, ($t2)
		# Reduce count of opponent
		addi $s4, $s4, -1
		# Display opponent's count
		jal displayCount
		# Check winner
		beq $s4, 0, playerWin
		# Branching
		beq $s5, 0, playerBattack
		j playerAattack		
	notHit:
		# Print not hit
		li $v0, 4
		la $a0, str_not_hit
		syscall
		# Display opponent's count
		jal displayCount
		# Branching
		beq $s5, 0, playerBattack
		j playerAattack
displayCount:
	beq $s5, 0, displayBcount
	j displayAcount
	displayAcount:
		# Sentence
		li $v0, 4
		la $a0, str_countA 
		syscall
		# Display countA
		li $v0, 1
		move $a0, $s4
		syscall
		# Update count
		move $s1, $s4
		# Endl
		li $v0, 4
		la $a0, str_endl
		syscall
		j breakfunc
	displayBcount:
		# Sentence
		li $v0, 4
		la $a0, str_countB 
		syscall
		# Display countB
		li $v0, 1
		move $a0, $s4
		syscall
		# Update count
		move $s2, $s4
		# Endl
		li $v0, 4
		la $a0, str_endl
		syscall
		j breakfunc
	breakfunc:
		jr $ra
playerWin:
	beq $s1, 0, Bwin
	j Awin
	Awin:
		li $v0, 4
		la $a0, str_A_win
		syscall
		j exit
	Bwin:
		li $v0, 4
		la $a0, str_B_win
		syscall
		j exit
		
######### Check valid #########
# For input	
validIndex:
	bge $s7, 0, greaterthan6
	j invalidInput
	greaterthan6:
		bge $s7, 7, invalidInput
		jr $ra	
validSize:
	ble $t9, 4, size2
	ble $t9, 9, size3
	ble $t9, 16, size4
	size2:
		li $v1, 1
		j branchForCheckSize
	size3:
		li $v1, 2
		j branchForCheckSize
	size4:
		li $v1, 3
		j branchForCheckSize
	branchForCheckSize: 
		beq $t3, $t5, checkSizeByRow
		beq $t4, $t6, checkSizeByColumn
		j invalidInput
	checkSizeByRow:
		sub $s7, $t6, $t4
		abs $s7, $s7
		bne $s7, $v1, invalidInput
		jr $ra
	checkSizeByColumn:
		sub $s7, $t5, $t3 
		abs $s7, $s7
		bne $s7, $v1, invalidInput
		jr $ra
invalidInput:
	li $v0, 4
	la $a0, str_invalidInput
	syscall
	ble $t9, 4, loop2x1
	ble $t9, 9, loop3x1
	ble $t9, 16, input4x1
# For attack
validAttack:
	# index >= 0?
	bge $s7, 0, greaterthan6_attack
	j invalidAttack
	greaterthan6_attack:
		# index >= 7?
		bge $s7, 7, invalidAttack
		jr $ra
	invalidAttack:
		li $v0, 4
		la $a0, str_invalidInput
		syscall
		j attack
######### Print matrix #########
printMatrix:
	li $t0, 0
	printLoop1:
		li $t1, 0
		printLoop2:	
			# Print value
        		lb $t2, ($s0) # Load value to $t2
        		li $v0, 1
        		move $a0, $t2 # Move value to $a0 to print
        		syscall
			# Print space
        		li $v0, 4        
        		la $a0, str_space
        		syscall
        		# Update address and index
        		addi $s0, $s0, 1 
        		addi $t1, $t1, 1 
        		bne $t1, 7, printLoop2
        	# Endl
        	li $v0, 4
        	la $a0, str_endl
        	syscall
    		# Update index
		addi $t0, $t0, 1
    		bne $t0, 7, printLoop1
    	jr $ra				
######### Exit #########
exit:
	li $v0, 10
	syscall

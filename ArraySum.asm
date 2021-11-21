.data 
arr: .space 40
prompt1: .asciiz "Enter 10 numbers:\n"
prompt2: .asciiz "Sum = "

.text
main:

li $v0, 4
la $a0, prompt1
syscall

li $t0,0 #Iniitalizing i=0
la $t1,arr #Pointing to arr[0]

inputLoop:
	slti $t2,$t0,10 #Checking if i < 10
	beq $t2,$zero,inputLoopExit #Terminating loop if i == 10
	
	#Getting input from user
	li $v0,5
	syscall
	
	#Storing input in memory
	sw $v0, ($t1)
	
	addi $t1,$t1,4 #Incrementing pointer position
	addi $t0,$t0,1 #Incrementing i
	
	j inputLoop
	
inputLoopExit:
	li $t0, 0 #Setting i=0
	la $t1, arr #Pointing to the 1st array element
	li $t2, 0 #Initializing sum to 0
	
	outputLoop:
		slti $t3,$t0,10 #Checking if i < 10
		beq $t3, $zero, outputLoopExit
		
		#Adding to sum
		lw $t4, ($t1)
		add $t2, $t2, $t4
		
		#Updating counter and pointer
		addi $t0, $t0, 1
		addi $t1, $t1, 4
		
		j outputLoop
		
		#Displaying the sum
	outputLoopExit:
		li $v0, 4
		la $a0, prompt2
		syscall
		
		li $v0, 1
		move $a0, $t2
		syscall
	
	
	
	
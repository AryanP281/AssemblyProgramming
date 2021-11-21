
.data
strLen: .word 0
offset: .word 0
prompt1: .asciiz "Enter string length: "
prompt2: .asciiz "Enter string: "
prompt3: .asciiz "\nReverse String: "

.text
main:
#Displaying prompt for string length
li $v0,4
la $a0, prompt1
syscall

#Getting string length
li $v0,5
syscall

#Setting string length
la $t0,strLen #Loading address for strLen variables
sw $v0,($t0) #Saving string length

#Allocating memory for string
li $v0,9
lw $a0,strLen
syscall
move $t0,$v0 #Saving the allocated address in t0

lw $t1,strLen #Getting the string length

#Reading the string
li $v0,4
la $a0,prompt2
syscall
li $v0,8
move $a0,$t0
move $a1,$t1
addi $a1,$a1,1
syscall

#Printing reverse string
subi $t1,$t1,1
sw $t1,offset #Getting strLen - 1 offset

#Poisitioning pointer
add $t2, $t0, $t1

lw $t3,offset #Counter initialized to n-1

#Printing prompt
li $v0,4
la $a0,prompt3
syscall

optLoop :
	slti $t4,$t3,0 #Checking if i < 0
	bne $t4,$zero,optLoopExit #Exiting loop if i < 0
	
	#Printing the character
	li $v0,11
	lbu $a0,($t2)
	syscall
	
	#Moving the character pointer
	subi $t2, $t2, 1
	
	#Updating counter
	subi $t3,$t3,1
	
	j optLoop
	
optLoopExit :
	


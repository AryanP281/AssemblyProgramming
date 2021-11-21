#Bubble sort

.data
arrLen: .word 0
arrStart: .word 0
i: .word 0
j: .word 0
prompt1: .asciiz "Enter array length: "
prompt2: .asciiz "\nEnter array elements:\n"
prompt3: .asciiz "\nSorted Array:\n"

.text
main:
#Printing prompt to enter array length
li $v0,4
la $a0,prompt1
syscall

#Getting array length
li $v0,5
syscall
sw $v0,arrLen

#Allocating memory
li $v0,9
lw $a0, arrLen
mul $a0,$a0,4
syscall
sw $v0, arrStart #Saving the pointer to the 1st array element

#Getting array elements
li $v0, 4
la $a0, prompt2
syscall
li $t0, 0 #i = 0
lw $t1, arrLen #Loading the array length in t1
lw $t2, arrStart #arr[0]
inputLoop:
slt $t3,$t0,$t1 #Chceking if i < arrLen
beq $t3,$zero,inputLoopExit #Exiting loop if i == arrLen

#Getting array element
li $v0,5
syscall
sw $v0,($t2)

#Updating counter and array pointer
addi $t0,$t0,1
addi $t2,$t2,4

j inputLoop #Continuing the loop

inputLoopExit:
#Initializing outer loop
lw $t0,arrLen #Saving array length in t0

outerSortLoop:
lw $t3,i #Loading i
slt $t3,$t3,$t0 #Checking if i < arrLen
beq $t3,$zero,sortExit

sw $zero,j #Initializing j=0
lw $t4, arrStart #arr[0]
innerSortLoop:
lw $t3, j
lw $t1,i
move $t2,$t0
sub $t2,$t2,1 #arrLen-1
sub $t2,$t2,$t1 #arrLen-i-1
slt $t3,$t3,$t2 #Checking if j < arrLen-i-1
beq $t3,$zero,innerSortLoopExit

#Getting arr[j]
lw $t2,($t4)

#Getting arr[j+1]
move $t3,$t4
addi $t3,$t3,4 #Pointer to arr[j+1]
lw $t3,($t3) #Getting arr[j+1]

#Checking if arr[j] > arr[j+1]
slt $t5,$t3,$t2 #Checking if arr[j+1] < arr[j]
beq $t5,$zero,ifEnd #Skipping switching if arr[j+1] >= arr[j]

#Switching arr[j] and arr[j+1]
move $t5, $t4
addi $t5,$t5,4 #Pointer to arr[j+1}
sw $t2,($t5)
sw $t3,($t4)
ifEnd:
lw $t3,j
addi $t3,$t3,1
sw $t3,j #j++
addi $t4,$t4,4 #Pointer to arr[j++] in t4

j innerSortLoop

innerSortLoopExit:
#Updating i and arr[i] pointer
lw $t3,i
addi $t3,$t3,1
sw $t3, i
addi $t1,$t1,4

j outerSortLoop

sortExit:
li $v0,4
la $a0,prompt3
syscall

li $t0,0 #i=0
lw $t1,arrStart #arr[i]
lw $t2, arrLen #Getting arrLen

outputLoop:
slt $t3,$t0,$t2 #Checking if i < arrLen
beq $t3,$zero,EXIT

li $v0,1
lw $a0,($t1)
syscall

li $v0,11
li $a0,','
syscall

addi $t0,$t0,1
addi $t1,$t1,4

j outputLoop

EXIT:



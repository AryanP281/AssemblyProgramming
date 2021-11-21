.data
msg: .asciiz "Hello MIPS"
.text
main:
li $v0,4
la $a0,msg
syscall

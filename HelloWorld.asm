
.model small ;Indicates that the program uses a max of 64kb of memory for code
.stack 100 ;Setting stack size to 100 bytes

.data ;The beginning of the data segment where program variables are stored
msg db "My first program in 8086!!$"

.code ;The code segment containing the instructions to be executed
    
    mov ax,@data ;Loading the address of the data segment into register ax
    mov ds,ax ;Moving address of data segment to ds register
    
    lea dx,msg ;Loading offset of msg from data segment into dx register
    mov ah,09h ;Code for printing string
    int 21h ;Interrupt to print string
    
    mov ah,4ch ;Code to exit program
    int 21h ;Interrupt to exit program

end
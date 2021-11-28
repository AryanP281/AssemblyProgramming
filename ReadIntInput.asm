.model small
.stack 100
   
.data
prompt1 db "Enter number: $"
num dw 0   
   
.code
    ;Updating data segment register
    mov ax,@data
    mov ds,ax

    ;Printing Prompt
    lea dx,prompt1
    mov ah,09h
    int 21h
    
    mov bx,0 ;Setting value in bx to 0
    
    read:
    ;Reading the input
    mov ah,01h
    int 21h
    
    ;Exiting loop if enter key is pressed
    cmp al,13 ;Comparing input value in al to 13(ASCII for carriage return)
    je exit
    mov cl,al ;Saving entered input in cl register
    mov ch,0h
    
    ;Converting to integer
    mov ax,10 ;Setting value of ax register to 10
    jc exit ;Checking if integer > 0hFFFF i.e cf=1   
    mul bx ;ax = ax*bx = 10*bx
    sub cl,48 ;Getting the input digit by subtracting from 48(ASCII for 0 digit)
    add ax,cx ;ax = ax + new digit
    jc exit ;Checking if integer > 0hFFFF i.e cf=1   
    mov bx,ax ;Saving the update integer in register bx
    
    jmp read
    
    
    exit:
    ;Saving the number
    mov [num],bx
      
    ;Exiting the program
    mov ah,4ch
    int 21h
   
end
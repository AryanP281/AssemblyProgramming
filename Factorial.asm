.model small
.stack 100

.data
   x db 6
   fact dw 0
   
.code
    factorial macro x
    mov ax,1
    mov bx,2
    
    mov cl,x
    and ch,00h
    dec cx
    
    facLoop:
        mul bx
        inc bx
        loop facLoop
    
    push dx    
    push ax
endm

    mov ax,@data
    mov ds,ax
    
    factorial x
    pop fact
    pop [fact+2]   

end
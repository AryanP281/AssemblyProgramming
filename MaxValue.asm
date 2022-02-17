.model small
.stack 100

.data
    x db 2
    y db 5
    half db 2 
    returnAddr dw 0
    
.code
    mov ax,@data
    mov ds,ax
    
    proc main
        
    endp
    
    proc pow
        pop returnAddr
        pop ax ;y
        
        ;y/2
        mov dx,ax
        div half
        and ah,00h
        push returnAddr
        push dx ;curr y
        push ax ;next y(y/2)
        call pow
        
        pop bx ;x^y/2
        pop ax ;curr y
        test al,01h ;Checking if y is even
        jz yEven
        
        yEven:
        mov ax,bx
        mul 
            
    endp
    
    
    
end
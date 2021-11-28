
.model small
.stack 100

.data
src db 10 dup(10)
dest db 10 dup(0)

.code
   mov ax,@data
   mov ds,ax
   
   mov cx,10 ;Setting counter
   lea si, [src] ;Getting pointer to source block
   lea di, [dest] ;Getting pointer to destination block
   transferLoop:
        mov ah, [si] ;Loading byte from source
        mov [di], ah ;Transferring source block to destination
        add si,1 ;Updating source pointer
        add di,1 ;Updating destination pointer
        loop transferLoop
        
   ;Exiting the program 
   mov ah,4ch
   int 21h
   
end
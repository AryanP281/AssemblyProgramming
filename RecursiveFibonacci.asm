
.model small
.stack 1024

.data
fibVal dw 0

.code
mov ax, @data
mov ds, ax

main proc
    mov ax,07h
    push ax
    call fib
    
    ;Saving the fibonaci value
    pop ax ;Getting the returned result
    mov [fibVal], ax
    
    ;Exiting
    mov ah, 4ch
    int 21h
    
endp

fib proc ;Fibonacci(x)
   pop si ;Getting the call address
   
   pop ax ;Getting x
   
   cmp ax,0 ;if(x==0)
   jne cmpOne
   mov ax,0 ;fib(0) = 0
   push ax ;Return fib(0)
   push si ;Restoring calling address
   ret      
   
   cmpOne:
   cmp ax,1  ;if(x==1)
   jne recurse
   mov ax,1 ;fib(1) = 1
   push ax ;Return fib(1)
   push si ;Restoring calling address
   ret
   
   recurse:
    sub ax,1 ;x-1
    push si ;Saving the calling address
    push ax ;Saving state
    push ax ;Setting argument to recursive call
    call fib
    pop bx ;Getting fib(x-1)
    
    pop ax ;Getting state of x
    sub ax,1 ;x-2
    push bx ;Saving state for fib(x-1)
    push ax
    call fib
    pop cx ;Getting fib(x-2)
    
    pop bx ;Restoring fib(x-1)
    add bx,cx ;fib(x) = fib(x-1) + fib(x-2)
    pop si ;Getting the calling address
    push bx
    push si ;Restoring calling address
ret    
endp
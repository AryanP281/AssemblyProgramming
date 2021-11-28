
.model small
.stack 100

.data
arr dw 14,88,5,34,2,99,100
minVal dw 0
maxVal dw 0

.code
   mov ax,@data
   mov ds,ax
   
   mov ax,0ffffh ;The currently encountered min value
   mov bx,0 ;The currently encounterd max value
   lea si,arr ;Pointer to array start
   mov cx,7 ;Counter
   
   minMaxLoop:
    cmp ax,[si] ;Comparing the current value to min value
    jb getMax
    mov ax,[si]
    
    getMax:
    cmp bx,[si] ;Comparing the current value to max value
    jae cmpEnd
    mov bx,[si]
    
    cmpEnd:
    add si,2 ;Updating array pointer
    loop minMaxLoop
    
    ;Saving the min and max values
    mov [minVal],ax
    mov [maxVal],bx
    
    ;Exiting the program
    mov ah,4ch
    int 21h

end
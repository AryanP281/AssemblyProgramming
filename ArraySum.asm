.model small
.stack 1024

.data
arrSize dw 0
arrSum dw 0 
prompt1 db "Enter array size(<=100): $"
prompt2 db "Enter array elements:",10,13,"$"
prompt3 db "Array Sum = $"
arr dw 100dup(0) 

.code
mov ax,@data
mov ds,ax

main proc
    ;Displaying prompt for array size
    lea dx,prompt1
    mov ah,09h
    int 21h
    
    call readInt ;Getting array size input
    
    ;Saving the entered array size in variable
    mov [arrSize],bx
    
    ;Getting the array elements
    lea dx,prompt2
    mov ah,09h
    int 21h
    mov cx,bx ;Setting counter to array size
    lea si,arr ;Pointer to arr[0]
    arrInptLoop:
           push cx ;Saving the counter value in stack
           call readInt
           pop cx  ;Restoring the counter value
           mov [si],bx ;Adding element to arr[i]
           add si,2 ;arr[i+1]
           loop arrInptLoop ;Looping
           
    ;Calculating sum
    mov ax, 0 ;Setting sum to 0
    mov cx, 1 ;Setting counter to 1
    lea si,arr ;Pointer to arr[0]
    sumLoop:
        add ax,[si]
        cmp cx,[arrSize] ;Comparing i to array size
        jae sumLoopExit ;Breaking loop if i >= array size
        add si,2 ;arr[i+1]
        inc cx ;i++
        jmp sumLoop
        
    sumLoopExit:
    mov [arrSum],ax ;Saving array sum in variable
    ;Displaying prompt for array sum
    lea dx,prompt3
    mov ah,09h
    int 21h
    
    ;Printing the word
    push [arrSum]
    call printInt  
    
    
    ;Exiting the program
    mov ah,4ch
    int 21h   
endp


readInt proc
   ;Reading the array size          
    mov bx,0 ;Initializing integer to 0
    readInptLoop:
    ;Reading char from input
    mov ah,01h
    int 21h
    
    ;Exiting loop if enter key is pressed
    cmp al,13
    je readInptLoopExit
    
    ;Saving the entered digit in cx register
    mov cl,al
    mov ch,0
    
    ;Converting to integer
    mov ax,10
    jc readInptLoopExit ;Checking if integer > 0hFFFF i.e cf=1
    mul bx ;x = x*10
    sub cl,48 ;ASCII to digit
    add ax,cx ;x = x + new digit
    jc readInptLoopExit ;Checking if integer > 0hFFFF i.e cf=1
    mov bx,ax
    
    jmp readInptLoop
    readInptLoopExit: 
ret    
readInt endp


printInt proc
   pop ax ;Getting the calling address
   mov si,ax ;Saving the calling address in si
   
   mov bh, 10
   pop ax ;Getting the word to print
   mov cl,0 ;Setting counter to count digits
   digitLoop:
    div bh ;int /= 10
    push ax ;Pushing the result to stack
    mov ah,0 ;Clearing the remainder
    inc cl ;Incrementing the digit counter
    cmp al,0 ;Checking if all digits have been extracted
    je digitLoopExit
    jmp digitLoop
   
   digitLoopExit: 
   mov ch, 0
   digitLoopPrint:
    pop dx
    sar dx,8 ;Moving remainder from ah to al for printing 
    add dl, 48 ;Int to ASCII
    mov ah,02
    int 21h ;Printing the digit
    loop digitLoopPrint
   
   push si ;Pushing the calling address to stack 
ret    
endp
   
   
end



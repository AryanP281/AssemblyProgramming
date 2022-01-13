.model small
.stack 1024

.data
n db 10
arr dw 5,18,2,30,12,16,100,8,9,43
currReturnAddr dw 0
currResultSize db 0
res1Len db 0
res2Len db 0

.code
   ;Initializing data segment
   mov ax, @data
   mov ds, ax
   
   getBufferPtr macro l 
       mov di,0000h      
       mov ax,0000h
       mov al,l
       mov bl,2
       mul bl
       add di,ax
   endm 

main proc
   mov ah,0
   mov al,n
   sub al,1
   push ax
   call mergesort
   
   mov ah,4ch
   int 21h
   
endp

mergesort proc
    pop ax ;Storing the return address in dx
    mov currReturnAddr, ax ;Saving the current return address
    pop ax ;Getting the l and r values
    
    ;Calculating r-l
    mov dl,al
    sub dl,ah ;r-l
    
    ;Checking r-l
    cmp dl,0
    jle singleOrNoElement ;l>=r
    
    ;Calculating midpoint
    mov dx,ax ;Saving the l & r values before division
    add al,ah ;r+l
    and ah,00h ;Clearing ah
    mov bl,2
    div bl ;(r+l)/2 = midpoint. Al=quotent,ah=remainder
    mov ah,dh ;ah = l, al=midpoint
    
    push currReturnAddr ;Storing the return address for the current recursion
    push dx ;The current l & r values
    mov bl,al
    and bh,00h ;bx=midpoint
    push bx ;The current midpoint
    push ax ;The l&r for the next recursion
    call mergesort 
    
    pop bx ;bl=midpoint
    pop dx ;l&r values
    mov ah,bl
    add ah,1
    mov al,dl ;ah=midpoint+1,al=r
    push dx ;The current l&r values
    push ax ;The next l&r values
    call mergesort
    
    ;Transferring results to buffer
    pop dx ;Getting the l&r values
    mov cx,0001h
    add cl,dl
    sub cl,dh ;r-l+1
    lea si,arr
    mov ax,0
    mov al,dh
    mov bl,2
    mul bl
    add si,ax ;Getting the position of arr[l]
    getBufferPtr dh ;Getting position of buffer start
    cld ;Clearing the direction flag
    rep movsw
    
    ;Sorting
    mov si,0000h
    mov di, 0000h
    mov ax,dx
    mov res2Len,al
    sub res2Len,ah
    inc res2Len
    mov cl,8
    shr ax,cl ;ah=0,al=l
    mov bl,2
    mul bl
    mov si,ax 
    mov cl,res2Len
    mov ax,dx ;ah=l,al=r
    add al,ah ;r+l
    and ax,00ffh ;Clearing ah
    div bl ;(r+l)/2
    mov res1Len,al
    sub res1Len,dh ;length = midpoint-l
    inc res1Len
    mov bl,res2Len
    sub bl,res1Len
    mov res2Len,bl
    inc al
    mov bl,2
    mul bl 
    and ax,00ffh ; Clearing ah
    mov di,ax ;Ptr to midpoint
    mov al,dh ;al=l
    mov bl,2
    mul bl ;
    lea bx,arr
    add bx,ax ;bx=(arr+l)
    sortLoop:
         mov ax,es:[si]
         mov dx,es:[di]
  
         cmp res1Len,0
         je fromRes2
         cmp res2Len,0
         je fromRes1
         
         cmp ax,dx
         jl fromRes1
         
         fromRes2:
         mov [bx],dx
         add di,2
         add bx,2
         dec res2Len
         loop sortLoop
         
         jmp sortLoopEnd
          
         fromRes1:
         mov [bx],ax
         add si,2
         add bx,2
         dec res1Len
         loop sortLoop
    sortLoopEnd:
    ret
     
    
    singleOrNoElement:
    push currReturnAddr
    ret
    
endp

end
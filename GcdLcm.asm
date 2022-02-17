.model small
.stack 100

.data
   a dw 6
   b dw 8
   currReturnAddr dw 0
   gcdRes dw 0 
   lcmRes dw 0
   
.code
    mov ax,@data
    mov ds,ax
    
    proc main
       ;push a
       ;push b
       ;call gcd
       ;pop gcdRes
       
       push a
       push b
       call lcm
       pop lcmRes  
    endp
    
    
    proc gcd
        pop currReturnAddr
        pop bx ;b
        pop ax ;a
        
        cmp ax,0000h
        je aZero
        
        cmp bx,0000h
        je bZero
        
        cmp ax,bx
        je bZero
        jl aLess
        
        push currReturnAddr
        sub ax,bx
        push ax
        push bx
        call gcd
        pop ax
        pop currReturnAddr
        push ax
        push currReturnAddr
        ret
        
        aZero:
            push bx
            push currReturnAddr
            ret
        
        bZero:
            push ax
            push currReturnAddr
            ret
        
        aLess:
            push currReturnAddr
            sub bx,ax
            push ax
            push bx
            call gcd
            pop ax
            pop currReturnAddr
            push ax
            push currReturnAddr
            ret
            
    endp
    
    proc lcm
        pop currReturnAddr
        pop bx ;b
        pop ax ;a
        
        cmp ax,bx
        jl aIsLess
        mov si,ax
        mov di,bx
        jmp lcmCalc
        
        aIsLess:
           mov si,bx
           mov di,ax
           jmp lcmCalc
           
        lcmCalc:
            mov cx,si
        
        lcmLoop:
            mov dx,di
            and dh,00h
            mov ax,cx
            div dl
            cmp ah,00h
            je endLcmLoop
            
            add cx,si
            jmp lcmLoop
            
        endLcmLoop:
            push cx 
            push currReturnAddr
            ret
        
        
    endm
     

end
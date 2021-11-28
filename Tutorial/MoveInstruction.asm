

.code
main proc
    mov ax,bx ;Reg,Reg
    mov [bx],ax ;Mem,Reg
    mov ax,[bx] ;Reg,Mem
    mov [bx+si],5 ;Mem,Immediate
    mov ax,5 ;Reg,Immediate
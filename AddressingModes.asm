.model small
.stack 10
 
.data
x dw 256
y dw 15
z db 20,21,22,23


.code
    mov ax, @data
    mov ds, ax
    
    mov ax,0
    
    mov al,ds:[0005h] ;Displacement Addressing
    
    ;Register Indirect Addressing
    mov bx, 06h
    mov al, [bx]
    
    mov ax, 25
    push ax
    mov bp,sp
    mov bx, [bp]
    
    ;Indexed Addressing Mode
    mov si,3
    mov al, [si+4h]
    
    ;Based Addressing Mode
    mov bx, 4
    mov si, 2
    mov al,[bx+si]
    
    ;Based indexed addressing
    mov bx, 1
    mov di, 2
    mov al, [bx+si+4h]
      
   
end


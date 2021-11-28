
.model small
.stack 100

.data
num1 dw 50000
num2 dw 20000
sum dw 0
carry db 0

.code
   mov ax,@data
   mov ds,ax
   
   mov ax,[num1]
   add ax,[num2]
   
   mov [sum],ax
   jae exit
   mov [carry],1
   
   exit:
   mov ah,4ch
   int 21h
   
end
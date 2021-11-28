
;Variable declaration syntax - VAR_NAME datatype value
;Data Types - (1) DB (define byte) (2) DW (define word)

.data
str1 db "Hello World" ;String with terminating character($)
str2 db "Hello World$" ;String with terminating character($)  
str3 db 10,13,"Hello World$" ;Bytes 10,13 provide newline character (\n)
x dw 10 ;Word variable
y db 11 ;Byte variable
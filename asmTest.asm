;.code
;SomeFunction proc
;	mov ax, -1
;	mov ah, 0
;	ret
;SomeFunction endp
;end

;.code
;SomeFunction proc
;	push rbx
;
;	mov bx, 29
;	mov bh, 67
;
;	pop rbx
;	ret
;SomeFunction endp
;end

;.code
;registersTest proc
;	mov rax, -1
;
;	mov al, 5
;	mov ax, 17
;
;	mov eax, 1
;
;	ret
;registersTest endp
;end

;.code
;registersTest proc
;	mov r11, -1
;
;	mov r11b, 5
;	mov r11w, 17
;
;	mov r11d, 1
;
;	ret
;registersTest endp
;end


;.data 
;myByte db 78
;myWord dw 678
;myReal4 real4 89.5
;.code
;SomeFunction proc
;	mov myByte, r11b
;	mov al, myByte
;	lea rbx, myByte
;	mov byte ptr [rbx], 127
;	ret
;SomeFunction endp
;end

;.code
;addTestFunc proc
;	mov al, 10
;	mov ah, 20
;
;	add ah, al
;
;	ret
;addTestFunc endp
;end

;.data
;myWord sqword 200
;.code
;addTestFunc proc
;	xor rcx, rcx
;	add rcx, 2147483648 ;Original num is 0x80000000. However, gets stored in rcx as 0xFFFFFFFF80000000 i.e -2147483648
;	mov myWord, rcx ;As rcx contains -2147483648, myWord is assigned the value -2147483648 instead of the original
;	ret
;addTestFunc endp
;end


.data
myWord sqword ?
.code
addTestFunc proc
	xor rcx, rcx
	mov rax, 2147483648
	add rcx, rax
	mov myWord, rcx
	ret
addTestFunc endp
end

.model small
.stack 100

.data
   arr dw 11,6,90,1,73,22
   arrSize dw 6
   prompt1 db "Sort in ascending? $"
   
   
.code
    mov ax,@data
    mov ds,ax
    
    ;Showing prompt to get sorting order
    lea dx, prompt1
    mov ah,09h
    int 21h
    
    ;Getting sorting order
    mov ah,01h
    int 21h
    
    cmp al,49
    je ascendingSort
    
    descendingSort:
        mov cx,[arrSize] ;i = 6
        dscSortOuterLoop:
            lea si,arr ;Pointer to start of array
            push cx ;Saving i
            sub cx,1 ;j = size-i-1
            dscSortInnerLoop:
                mov ax, [si] ;arr[j]
                add si,2 ;j+1
                mov bx,[si] ;arr[j+1]
                
                cmp ax,bx ;Comparing arr[j] and arr[j+1]
                jae dscSortInnerLoopUpdt ;Swapping if cf=1 i.e ax > bx
                mov [si],ax
                mov [si-2], bx
                
                dscSortInnerLoopUpdt:
                    loop dscSortInnerLoop ;Looping again
                    
            pop cx ;Getting i
            dec cx ;i--
            cmp cx,1
            je exit
            
            jmp dscSortOuterLoop
            
    
    ascendingSort:
        mov cx,[arrSize] ;i = 6
        ascSortOuterLoop:
            lea si,arr ;Pointer to start of array
            push cx ;Saving i
            sub cx,1 ;j = size-i-1
            ascSortInnerLoop:
                mov ax, [si] ;arr[j]
                add si,2 ;j+1
                mov bx,[si] ;arr[j+1]
                
                cmp ax,bx ;Comparing arr[j] and arr[j+1]
                jbe ascSortInnerLoopUpdt ;Swapping if cf=1 i.e ax > bx
                mov [si],ax
                mov [si-2], bx
                
                ascSortInnerLoopUpdt:
                    loop ascSortInnerLoop ;Looping again
                    
            pop cx ;Getting i
            dec cx ;i--
            cmp cx,1
            je exit
            
            jmp ascSortOuterLoop  
    
    
    exit:
    ;Exiting
    mov ah,4ch
    int 21h

end

; Array Declaration - ARRAY_NAME dataType values

.data
arr1 db 10h,22h,32h ;Byte Array = {0h10,0h22,0h32)
arr3 db 3dup(7) ; Similar to arr3 db 7,7,7
arr4 db 3dup(5,6) ;Similar to arr4 db 5,6,5,6,5,6

.code
main proc
    mov al,arr1[2] ;Move arr[2] to al register
    
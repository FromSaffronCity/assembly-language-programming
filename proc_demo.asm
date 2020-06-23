.model small
.stack 100h
.data   
    address dw ?

.code
    main proc   
        
        call println 
        pop ax
        
        mov ah, 2  
        mov dl, al
        int 21h  
        
        mov ah, 4ch
        int 21h
    main endp
    
    println proc 
 
        mov ah, 2  
        mov dl, 'f'
        int 21h 
        
        pop address
        
        push dx
        push address 
        
        ret
    println endp
end main
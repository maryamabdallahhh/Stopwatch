 
org 100h
 

.model small
.stack 100h
.data
    elapsed_time db "00:00:00$"   
    control db  " Press Any Key To Stop $"   
    start db 10,13," Elapsed  Time  : $"

.code
main proc
    mov ax, @data
    mov ds, ax 

    
    mov ah, 00h
    mov al, 03h   
    int 10h  

    
    
    lea dx, control
    mov ah, 09h
    int 21h

    lea dx, start
    mov ah, 09h
    int 21h
    
    
    start_timer:
        
        call check_keypress
        cmp al, 0  
        je continue_timer
        
        jmp exit_program

    continue_timer:
        call update_display
        call delay_1_second
        call increment_time
        jmp start_timer

   
    exit_program:
        mov ah, 4ch
        int 21h

main endp

 
check_keypress proc
    mov ah, 01h  
    int 16h       
    
    jz no_key_pressed
    
    ret

    no_key_pressed:
    mov al, 0    
    ret
check_keypress endp

 
update_display proc
   
    mov ah, 02h
    mov bh, 0
    mov dh, 12   
    mov dl, 35   
    int 10h

    
    mov ah, 09h
    lea dx, elapsed_time
    int 21h

    ret
update_display endp

 
delay_1_second proc
    mov cx, 0fh
    mov dx, 4240h
    mov ah, 86h
    int 15h
    ret
delay_1_second endp

 
increment_time proc
    
    inc elapsed_time[7]
    cmp elapsed_time[7], '9'
    jle done_increment

    mov elapsed_time[7], '0'
    inc elapsed_time[6]
    cmp elapsed_time[6], '6'
    jl done_increment

    
    mov elapsed_time[6], '0'
    inc elapsed_time[4]
    cmp elapsed_time[4], '9'
    jle done_increment

    mov elapsed_time[4], '0'
    inc elapsed_time[3]
    cmp elapsed_time[3], '6'
    jl done_increment

   
    mov elapsed_time[3], '0'
    inc elapsed_time[1]
    cmp elapsed_time[1], '9'
    jle done_increment

    mov elapsed_time[1], '0'
    inc elapsed_time[0]

done_increment:
    ret
increment_time endp

end main



ret





include 'emu8086.inc' 
org 100h

.data
ids dw 25 dup(?)  ;initialize array with null 
time dw 25 dup(?)   

.code

start: mov bx,0      ;iterator
       print 'Enter Player ids: '
       printn        ;prints a new line          
readids: cmp bx,50     ;get players ids
       jz test1
       call scan_num   ;macro call
       mov ax,cx
       mov ids[bx],ax
       printn
       add bx,2
       jmp readids
       
         
test1: print 'Enter their corresponding running times(in seconds):'
       printn
       
       mov bx,0  
readtime: cmp bx,50    ;get players running time
       jz terminate
       call scan_num
       mov ax,cx
       mov time[bx],ax
       printn
       add bx,2
       jmp readtime 
       
terminate: mov si,0
       mov cx,50       
         
compare: cmp si,cx       ;compare for bubble sort
       jz next
       mov ax,time[si]
       mov bx,time[si+2]
       cmp ax,bx
       ja swap
       add si,2
       jmp compare
       
       
swap:  mov time[si],bx    ;swap if time[bx]>time[bx+1] and swap their ids
       mov time[si+2],ax 
       mov ax,ids[si]
       mov bx,ids[si+2]
       mov ids[si],bx
       mov ids[si+2],ax
       add si,2
       jmp compare
       
next:  mov si,0          ;next iteration in bubble sort
       sub cx,2
       cmp cx,0
       jnz compare
       
       mov si,0
       mov cx,25
       
       printn
       
printarray: print 'Player id: '       ;print players running time in ascending order with their corresponding time
       mov ax,ids[si]
       call print_num
       printn
       print 'Running time: '
       mov ax,time[si]
       call print_num
       printn
       add si,2
       loop printarray
       ret                          
       
       define_scan_num
       define_print_num
       define_print_num_uns
       define_pthis
        
end start
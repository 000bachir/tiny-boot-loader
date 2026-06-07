bits 16
org 0x7C00
xor ax , ax
mov ds , ax 
mov ax , 07E0h
mov ss , ax 
mov sp , 2000h 

call clearscreen

push 0000h 
call movecursor 
add sp, 2
push msg 
call print 
add sp , 2 
cli 
hlt 
clearscreen :
  push bp 
  mov bp , sp 
  pusha 
  mov ah , 0x06 ; scrolls up 
  mov al , 0x00; clears entire window
  mov bh , 0x07 ; white on black fill attribute  
  mov cx , 0x0000 ; top left : row zero , col zero 
  mov dh , 0x18 ; bottom row 24
  mov dl , 0x4f ; bottom col : 79
  int 0x10

  popa 
  mov sp , bp 
  pop bp 
  ret
  

  movecursor : 
    push bp 
    mov bp , sp 
    pusha 

    mov dx , [bp+4]
    mov ah , 02h 
    mov bh , 00h 
    int 10h 


    popa 
    mov sp , bp 
    pop bp 
    ret 


    print : 
      push bp 
      mov bp , sp 
      pusha 
      mov si , [bp+4] ; need to use the argument from stack not the hard coded
      mov bh , 00h 
      mov bl , 0x07 ; ligh gray on black 0x00 is invisible 
      mov ah , 0Eh 
    .char : 
      mov al , [si]
      add si , 1
      or al , 0 
      je .return 
      int 10h 
      jmp .char 
    .return: 
      popa 
      mov sp , bp 
      pop bp 
      ret 
  msg : db "i have no idea what am doing", 0 ; null terminator was missing
    times 510-($-$$) db 0 
    dw 0xAA55





; works on qemu x86_64
[org 0x7c00] ; tell the assembler that our offset is bootsector code

; chars are just arrays except in assembly theres no way to index except increasing the pointer adress
; use bx for storing char
start:
    mov ebx, test; Get addr of test
    call println
    jmp $
println:
    mov al, [ebx] ; Get whatever is at ebx <- &test
    cmp al, 0 ; ret if null
    je nlret

    mov ah, 0x0e ; Write text BIOS call
    int 0x10 ; Prints whatever is in %al
    add ebx,1 ; Increment index
    jmp println ; loop
nlret:
    mov al, 0x0A
    mov ah, 0x0E
    int 0x10
    mov al, 0x0D
    mov ah, 0x0E
    int 0x10
    ret

test: db "shid",0xa,0x0d,"came"
times 510-($-$$) db 0
dw 0xaa55

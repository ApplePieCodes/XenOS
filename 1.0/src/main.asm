/* Kickoff bootloader. Unauthorized access is STRICTLY PROHIBITED! Built in ASM(God Help me).
This took way too long(Im atheist)*/
org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main
; Prints a string to screen
; ds:si points to a string
puts:
    push si
    push ax

.loop:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0e
    int 0x10

    jmp .loop

.done:
    pop ax
    pop si
    ret

main:

    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00

    ;print message
    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello World!', ENDL, 0


times 510-($-$$) db 0
dw 0AA55h
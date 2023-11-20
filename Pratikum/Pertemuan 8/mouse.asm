.MODEL SMALL
.CODE
org 100h

proses:
    jmp start
    oldX dw -1
    oldY dw 0

start:
    ; ubah ke mode grafik
    mov ah,00
    mov al,13h      ;layar 256 warna, berukurang 320x320 pixel.
    int 10h        
    ; reset mouse status saat ini
    mov ax,0
    int 33h
    cmp ax,0

    ;tampilkan kursor mouse
    mv ax,1
    int 33h

check_mouse_button:
    mov ax,3
    int 33h
    shr cx,1            ; x/2 - di mode ini, value dari CX adalah 2x lipat
    cmp bx,1
    jne xcr_cursor
    mov al,1010b        ; warna pixel
    jmp draw_pixel
xor_cursor:
    cmp oldX,-1
    je not_required
    push cx
    push dx
    mov cx, oldX
    mov dx, oldY
    mov ah, 0dh         ; mendapatkan pixel
    int 10h

    xor al, 1111b       ; warna pixel
    mov ah, 0ch         ; set pixel
    int 10h
    pop dx
    pop cx
not_required:
    mov ah,0dh          ;mendapatkan pixel
    int 10h 
    xor al, 1111b       ;pixel color
    mov oldX,cx
    mov oldY,dx

draw_pixel:
    mov ah,0ch          ; set pixel
    int 10h

check_esc_key:
    mov dl,255
    mov ah,6
    int 21h
    cmp al,27           ;esc?
    jne check_mouse_button
stop:
    ;mov ax,2           ; hide mouse cursor.
    ;int 33h
    mov ax,3            ; back to text mode: 80x25
    int 10h
    ; show box-shaped blinking text cursor:
    mov ah,1
    mov ch,0
    mov cl,8
    int 10h
    mov dx,offset msg
    mov ah,9
    int 21h
    mov ah,0
    int 16h
    ret
msg db " press any key....       $"
end proses
; Arquivo: LCDQuadrado.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Desenhe um quadro no LCD
leaw $16550, %A
movw %A, %D
leaw $1, %A
movw %D, (%A)
ESQUERDA:
    leaw $1, %A
    movw (%A), %D
    movw %D, %A
    movw $-1, (%A)
    leaw $20, %A
    addw %D, %A, %D
    leaw $1, %A
    movw %D, (%A)
    ; if %D >= 19110
    leaw $19110, %A
    subw %D, %A, %D
    ; if %D >= 0, END
    leaw $DIREITA, %A
    jge %D
    nop
    ; LOOP
    leaw $ESQUERDA, %A
    jmp
    nop
DIREITA:
    leaw $16558, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    LOOP1:
        leaw $1, %A
        movw (%A), %D
        movw %D, %A
        movw $-1, (%A)
        leaw $20, %A
        addw %D, %A, %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 19218
        leaw $19218, %A
        subw %D, %A, %D
        ; if %D >= 0, END
        leaw $ALTO, %A
        jge %D
        nop
        ; LOOP
        leaw $LOOP1, %A
        jmp
        nop
ALTO:
    leaw $16550, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    leaw $2, %A
    movw %D, (%A)
    ALTON:
        leaw $2, %A
        movw (%A), %D
        leaw $1, %A
        addw %D, %A, %D
        movw %D, (%A)
        leaw $2, %A
        movw %D, (%A)
        ; if RAM[1] >= 16558
        leaw $16558, %A
        subw %D, %A, %D
        leaw $BAIXO2, %A
        jge %D
        nop
    LOOP2:
        leaw $1, %A
        movw (%A), %D
        movw %D, %A
        movw $-1, (%A)
        leaw $20, %A
        addw %D, %A, %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 16718
        leaw $16718, %A
        subw %D, %A, %D
        leaw $ALTON, %A
        jge %D
        nop
        leaw $LOOP2, %A
        jmp
        nop
BAIXO2:
    leaw $19109, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    leaw $2, %A
    movw %D, (%A)
    BAIXO2N:
        leaw $2, %A
        movw (%A), %D
        leaw $1, %A
        addw %D, %A, %D
        movw %D, (%A)
        leaw $2, %A
        movw %D, (%A)
        ; if RAM[1] >= 19119
        leaw $19119, %A
        subw %D, %A, %D
        leaw $FIM, %A
        jge %D
        nop
    LOOP3:
        leaw $1, %A
        movw (%A), %D
        movw %D, %A
        movw $-1, (%A)
        leaw $20, %A
        addw %D, %A, %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 19278
        leaw $19278, %A
        subw %D, %A, %D
        leaw $BAIXO2N, %A
        jge %D
        nop
        leaw $LOOP3, %A
        jmp
        nop
FIM:

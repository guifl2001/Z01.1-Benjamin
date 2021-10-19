; Arquivo: LCDletraGrupo.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Escreva no LCD a letra do grupo de vocês
;  - Valide no hardware
;  - Bata uma foto!
; RAM[1] = 16550 (Inicio do B)
leaw $16550, %A
movw %A, %D
leaw $1, %A
movw %D, (%A)
VERTICAL:
    leaw $1, %A
    ; %D = RAM[1]
    movw (%A), %D
    ; %A = %D
    movw %D, %A
    ; RAM[%A] = -1
    movw $-1, (%A)
    ; %A = 20
    leaw $20, %A
    ; %D = %D + 20
    addw %D, %A, %D
    ; RAM[1] = %D
    leaw $1, %A
    movw %D, (%A)
    ; if %D >= 20784 (linha numero 20): END
    leaw $20784, %A
    ; %D = %D - 20784
    subw %D, %A, %D
    ; if %D >= 0, END
    leaw $MEIO, %A
    jge %D
    nop
    ; LOOP
    leaw $VERTICAL, %A
    jmp
    nop
MEIO:
    ; RAM[1] = 18670 (meio do B)
    leaw $18670, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    ; Usa RAM[2] como um segundo contador, para adicionar comprimento ao B
    leaw $2, %A
    movw %D, (%A)
    MEION:
        leaw $2, %A
        movw (%A), %D
        leaw $1, %A
        ; RAM[2] += 1
        addw %D, %A, %D
        ; RAM[1] = RAM[2]
        movw %D, (%A)
        leaw $2, %A
        movw %D, (%A)
        ; condicao de quebra: if RAM[1] >= 18676
        leaw $18676, %A
        subw %D, %A, %D
        leaw $HORIZONTAL1, %A
        jge %D
        nop
    LOOP1:
        ; %D = RAM[1]
        leaw $1, %A
        movw (%A), %D
        ; %A = %D
        movw %D, %A
        ; RAM[%1] = -1
        movw $-1, (%A)
        ; %D += 20
        leaw $20, %A
        addw %D, %A, %D
        ; RAM[1] = %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 18836 => para essa etapa
        leaw $18836, %A
        subw %D, %A, %D
        leaw $MEION, %A
        jge %D
        nop
        ; Continua o loop
        leaw $LOOP1, %A
        jmp
        nop
HORIZONTAL1:
    ; RAM[1] = 16550 (comeco da letra)
    leaw $16550, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    ; Usa RAM[2] como um segundo contador, para adicionar comprimento ao B
    leaw $2, %A
    movw %D, (%A)
    HORIZONTAL1N:
        leaw $2, %A
        movw (%A), %D
        leaw $1, %A
        ; RAM[2] += 1
        addw %D, %A, %D
        ; RAM[1] = RAM[2]
        movw %D, (%A)
        leaw $2, %A
        movw %D, (%A)
        ; condicao de quebra: if RAM[1] >= 16556
        leaw $16556, %A
        subw %D, %A, %D
        leaw $HORIZONTAL2, %A
        jge %D
        nop
    LOOP2:
        ; %D = RAM[1]
        leaw $1, %A
        movw (%A), %D
        ; %A = %D
        movw %D, %A
        ; RAM[%1] = -1
        movw $-1, (%A)
        ; %D += 20
        leaw $20, %A
        addw %D, %A, %D
        ; RAM[1] = %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 16716 => para essa etapa
        leaw $16716, %A
        subw %D, %A, %D
        leaw $HORIZONTAL1N, %A
        jge %D
        nop
        ; Continua o loop
        leaw $LOOP2, %A
        jmp
        nop
HORIZONTAL2:
    ; RAM[1] = 20610 (final da letra)
    leaw $20610, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
    ; Usa RAM[2] como um segundo contador, para adicionar comprimento ao B
    leaw $2, %A
    movw %D, (%A)
    HORIZONTAL2N:
        leaw $2, %A
        movw (%A), %D
        leaw $1, %A
        ; RAM[2] += 1
        addw %D, %A, %D
        ; RAM[1] = RAM[2]
        movw %D, (%A)
        leaw $2, %A
        movw %D, (%A)
        ; condicao de quebra: if RAM[1] >= 20616 (6 colunas de comprimento)
        leaw $20616, %A
        subw %D, %A, %D
        leaw $VERTICAL2, %A
        jge %D
        nop
    LOOP3:
        ; %D = RAM[1]
        leaw $1, %A
        movw (%A), %D
        ; %A = %D
        movw %D, %A
        ; RAM[%1] = -1
        movw $-1, (%A)
        ; %D += 20
        leaw $20, %A
        addw %D, %A, %D
        ; RAM[1] = %D
        leaw $1, %A
        movw %D, (%A)
        ; if %D >= 20776 => para essa etapa
        leaw $20776, %A
        subw %D, %A, %D
        leaw $HORIZONTAL2N, %A
        jge %D
        nop
        ; Continua o loop
        leaw $LOOP3, %A
        jmp
        nop
VERTICAL2:
    ; Fecha a primeira parte do B
    leaw $16716, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
LOOP4:
    leaw $1, %A
    ; %D = RAM[1]
    movw (%A), %D
    ; %A = %D
    movw %D, %A
    ; RAM[%A] = -1
    movw $-1, (%A)
    ; %A = 20
    leaw $20, %A
    ; %D = %D + 20
    addw %D, %A, %D
    ; RAM[1] = %D
    leaw $1, %A
    movw %D, (%A)
    ; if %D >= 18676
    leaw $18676, %A
    ; %D = %D - 18676
    subw %D, %A, %D
    ; if %D >= 0, END
    leaw $FIM, %A
    jge %D
    nop
    ; LOOP
    leaw $LOOP4, %A
    jmp
    nop
FIM:
    ; Termina a letra.
    leaw $18836, %A
    movw %A, %D
    leaw $1, %A
    movw %D, (%A)
LOOP5:
    leaw $1, %A
    ; %D = RAM[1]
    movw (%A), %D
    ; %A = %D
    movw %D, %A
    ; RAM[%A] = -1
    movw $-1, (%A)
    ; %A = 20
    leaw $20, %A
    ; %D = %D + 20
    addw %D, %A, %D
    ; RAM[1] = %D
    leaw $1, %A
    movw %D, (%A)
    ; if %D >= 20616
    leaw $20616, %A
    ; %D = %D - 20616
    subw %D, %A, %D
    ; if %D >= 0, END
    leaw $END, %A
    jge %D
    nop
    ; LOOP
    leaw $LOOP5, %A
    jmp
    nop
END:



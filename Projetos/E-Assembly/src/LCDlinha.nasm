; Arquivo: LCDQuadrado.nasm
; Curso: Elementos de Sistemas
; Criado por: Rafael Corsi
; Data: 28/3/2018
;
; Desenhe uma linha no LCD

leaw $16384, %A
movw $-1, %D
movw %D, (%A)
leaw $16385, %A
movw %D, (%A)
leaw $16386, %A
movw %D, (%A)
leaw $16387, %A
movw %D, (%A)
leaw $16388, %A
movw %D, (%A)
leaw $16389, %A
movw %D, (%A)
leaw $16390, %A
movw %D, (%A)
leaw $16391, %A
movw %D, (%A)
leaw $16392, %A
movw %D, (%A)
leaw $16393, %A
movw %D, (%A)
leaw $16394, %A
movw %D, (%A)
leaw $16395, %A
movw %D, (%A)
leaw $16396, %A
movw %D, (%A)
leaw $16397, %A
movw %D, (%A)
leaw $16398, %A
movw %D, (%A)
leaw $16399, %A
movw %D, (%A)
leaw $16400, %A
movw %D, (%A)
leaw $16401, %A
movw %D, (%A)
leaw $16402, %A
movw %D, (%A)
leaw $16403, %A
movw %D, (%A)

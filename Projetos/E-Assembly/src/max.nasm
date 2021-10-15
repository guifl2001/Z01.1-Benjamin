; Arquivo: Max.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares 
; Data: 27/03/2017
; Log :
;     - Rafael Corsi portado para Z01
;
; Calcula R2 = max(R0, R1)  (R0,R1,R2 se referem a  RAM[0],RAM[1],RAM[2])
; ou seja, o maior valor que estiver, ou em R0 ou R1 sera copiado para R2
; Estamos considerando número inteiros

leaw $R0,%A         ; carrega 0
movw (%A),%D       ; D = RAM[0]

leaw $R2,%A       ; RAM[2] = RAM[0] -> (Supondo RAM[0] > RAM[1])
movw %D, (%A)

leaw $R1, %A 
subw %D, (%A), %D ; Subrtraindo R1 de R0

leaw $IF, %A       ; precisamos carregar em %A o valor do salto
jle %D             ; Se %D <= 0, pula p/ o IF (Se R1 > R0)
nop

leaw $END, %A  ; agora não podemos executar o trecho 
jmp            ; do IF, vamos pular para o fim 
nop            ; do código

IF:
leaw $1, %A
movw (%A), %D 
leaw %2, %A 
movw %D, (%A)

END:
; Arquivo: Pow.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Eleva ao quadrado o valor da RAM[1] e armazena o resultado na RAM[0].
; Só funciona com números positivos
leaw $1, %A         ; carrega a constante 0 no registrador A --> %A = 1
movw (%A), %D       ; move o valor da RAM[%A] para %D --> %D = RAM[%A] --> %D = RAM[1]
leaw $2, %A         ; carrega a constante 2 no registrador A --> %A = 2 -- aqui poderia ser qualquer número 
movw %D, (%A)       ; move o valor de %D para RAM[%A] --> RAM[2] = RAM[1]

INICIO:

leaw $1, %A         ; carrega a constante 1 no registrador A --> %A = 1
movw (%A), %D       ; move/copia o valor da RAM[%A] para %D --> %D = RAM[%A] --> %D = RAM[1]

leaw $FIM, %A       ; onde salta o jump abaixo
je %D               ; salta a execução abaixo se %D = 0, ou seja, quando o valor de RAM[1] chegar a 0
nop                

leaw $2, %A         ; carrega a constante 2 no registrador A --> %A = 2
movw (%A), %D       ; move/copia o valor de %D para o RAM[$A] --> %D = RAM[%A]

leaw $0, %A         ; carrega a constante 0 no registrador A --> %A = 0
addw (%A), %D, %A   ; soma o primeiro valor + o segundo e guarda no terceiro --> %A = RAM[1] + RAM[0]
movw %A, %D         ; move/copia o valor do registrador A em %D --> %D = %A 

leaw $0, %A         ; carrega a constante 0 no registrador A --> %A = 0 
movw %D, (%A)       ; move/copia o valor da RAM[%A] em %D --> RAM[%A] = %D (soma de todos os RAM[1])

; pega o valor de RAM[0] pra continuar diminuindo

leaw $1, %A         ; carrega a constante 1 no registrador A --> %A = 1
movw (%A), %D       ; move/copia o valor de %D para RAM[%A] -->  %D = RAM[%A] --> %D = RAM[1]

decw %D             ; subtrai um (1) da memória
movw %D, (%A)       ; move/copia o valor de %D para RAM[%A] -->  %D = RAM[1] - 1

leaw $INICIO, %A
jmp
nop

FIM:
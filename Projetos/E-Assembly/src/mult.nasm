; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Multiplica o valor de RAM[1] com RAM[0] salvando em RAM[3]

; É mantido o valor de ram[1] constante e vai mexendo somente no ram[0]

INICIO:

leaw $0, %A         ; carrega a constante 0 no registrador A --> %A = 0
movw (%A), %D       ; move/copia o valor da RAM[%A] para %D --> %D = RAM[%A] --> %D = RAM[0]

leaw $FIM, %A       ; onde salta o jump abaixo
je %D               ; salta a execução abaixo se %D = 0, ou seja, quando o valor de RAM[0] chegar a 0
nop                

leaw $3, %A         ; carrega a constante 3 no registrador A --> %A = 3
movw (%A), %D       ; move/copia o valor da RAM[$A] para %D--> %D = RAM[%A] --> %D = RAM[3]

leaw $1, %A         ; carrega a constante 1 no registrador A --> %A = 1
addw (%A), %D, %A   ; soma o primeiro valor + o segundo e guarda no terceiro --> %A = RAM[1] + RAM[3]
movw %A, %D         ; move/copia o valor do registrador A em %D --> %D = %A 

leaw $3, %A         ; carrega a constante 3 no registrador A --> %A = 3 
movw %D, (%A)       ; move/copia o valor da RAM[%A] em %D --> RAM[%A] = %D (soma de todos os RAM[1] e RAM[0])

; pega o valor de RAM[0] pra continuar diminuindo

leaw $0, %A         ; carrega a constante 0 no registrador A --> %A = 0
movw (%A), %D       ; move/copia o valor de %D para RAM[%A] -->  %D = RAM[%A] --> %D = RAM[0]

decw %D             ; subtrai um (1) da memória --> %D = RAM[0] - 1
movw %D, (%A)       ; move/copia o valor de %D para RAM[%A] -->  RAM[0] = %D

leaw $INICIO, %A
jmp
nop

FIM:
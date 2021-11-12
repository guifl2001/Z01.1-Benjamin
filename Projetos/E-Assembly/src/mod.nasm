; ------------------------------------------------------------
; Arquivo: Mod.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017
;
; Calcula o resto da divisão (modulus) entre RAM[0] por RAM[1]
; e armazena o resultado na RAM[2].
;
; 4  % 3 = 1
; 10 % 7 = 3
; ------------------------------------------------------------
;r=x -yz
; o x é o RAM[0] e o y é o RAM[1] E O RESTO(R) recebera o RAM[2]

;iniciando o valor inicial de RAM[2] como zero para n afetar o resultado de saida
leaw $2, %A
movw $0, (%A)

;iniciando o loop que ira guardar o valor dos restos
LOOP: 
    ;movendo o valor de RAM[0] para o registrador D
    leaw $0, %A
    movw (%A), %D
    ;guardando no intermediario RAM[4] o valor dde RAM[0] antes da subtração
    leaw $4, %A
    movw %D, (%A)
    ;realiazando RAM[0]-RAM[1] e guardando no registrador D
    leaw $1, %A
    subw %D, (%A), %D 
    ;guardando o valor da subtração em RAM[0] para contnuacao do loop
    leaw $0, %A
    movw %D, (%A)
;condicao que analisa se RAM[0]-RAM[1] é <0 caso sim encaminha para a saIDA
leaw $SAIDA, %A
jl %D 
nop 
;caso a condicao acima nao seja cumprida volta para linha LOOP e executa novamente o LOOP descrito
leaw $LOOP, %A
jmp 
nop 
;saida deste modulo, copia o valor antes do valor RAM[4] para RAM[2]
SAIDA:
leaw $4, %A
movw (%A), %D

leaw $2, %A
movw %D, (%A)




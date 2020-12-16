#Rede Neural
#Neuronio Perceptron
#Marcelo Teixeira Alves, Thalles Sales

.data
#Primeiro e segundo valor a serem somados
val_1:            .word 1
val_2:            .word 1

val_3:            .word 1
val_4:            .word 1

#Dois pesos 
peso_1:           .float 0.0
peso_2:           .float 0.8

#Taxa de aprendizado padrao
taxa_aprendizado:        .float 0.05

#Erro
valor_erro:	.float 0.0

#Epoca
initial_epoca:  .word 1
tamanho_epoca:  .word 6 

#Strings
quebra_uma_result:  .asciiz "\n"
quebra_duas_result: .asciiz "\n\n"
entrada_result:	    .asciiz "Entrada:"
saida_result:	    .asciiz "Saida:"
operador_result:    .asciiz "+"

.text 
	#Atribuindo valores salvos na memoria em registradores
	lw $s0, initial_epoca
	lw $s1, tamanho_epoca
	lw $s2, val_1
	lw $s3, val_2
	lw $s4, val_3
	lw $s5, val_4
	l.s $f0, peso_1
	l.s $f1, peso_2
	l.s $f2, taxa_aprendizado
	l.s $f3, valor_erro
	
	
percorre_epoca:
	#Laco While para percorrer toda Epoca caso a condicao seja falsa
	beq $s0, $s1, teste
	
	#Convertendo valores inteiros para operacoes em FLOAT
	mtc1 $s2, $f4
	cvt.s.w $f4, $f4
	
	mtc1 $s3, $f5
	cvt.s.w $f5, $f5
	
	#Somando valores da Epoca para obter o valor esperado
	add.s $f6, $f4, $f5
	
	#Multiplicando valores pelos seus respectivos pesos
	mul.s $f4, $f4, $f0 
	mul.s $f5, $f5, $f1 
	
	#Somando os dois resultados e subtraindo pelo valor esperado para obter o erro
	add.s $f7, $f4, $f5
	sub.s $f3, $f6, $f7

	#Atualizando valores dos pesos
	#peso1
	mul.s $f8, $f3, $f2 #result = erro * taxa de aprendizado
	mul.s $f8, $f8, $f4 #result = result * entrada1
	add.s $f0, $f0, $f8 #peso1 = peso1 + result
	
	#peso2
	mul.s $f8, $f3, $f2 #result = erro * taxa de aprenziado
	mul.s $f8, $f8, $f5 #result = result * entrada2
	add.s $f1, $f1, $f8 #peso2 = peso2 + result
	
	#Atribuindo +1 aos valores da epoca
	addi $s2, $s2, 1
	addi $s3, $s3, 1
	
	#Atribuindo +1 ao valor do registrador $s0 e retornando para o looping(While)
	addi $s0, $s0, 1
	j percorre_epoca
	

teste:
	#Laco While para percorrer toda Epoca caso a condicao seja falsa
	beq $t0, 5, fim
	
	#Convertendo valores inteiros para operacoes em FLOAT
	mtc1 $s4, $f4
	cvt.s.w $f4, $f4
	
	mtc1 $s5, $f5
	cvt.s.w $f5, $f5
	
	#Somando valores da Epoca para obter o valor esperado
	add.s $f6, $f4, $f5
	
	#Multiplicando valores pelos seus respectivos pesos
	mul.s $f4, $f4, $f0 
	mul.s $f5, $f5, $f1 
	
	#Somando os dois resultados
	add.s $f7, $f4, $f5
	
	#Imprime Entrada
	li $v0, 4
	la $a0, entrada_result
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 4
	la $a0, operador_result
	syscall
	
	li $v0, 1
	move $a0, $s5
	syscall
	
	li $v0, 4
	la $a0, quebra_uma_result
	syscall
	
	li $v0, 4
	la $a0, saida_result
	syscall
	
	li $v0, 2
	mov.s $f12, $f7
	syscall
	
	li $v0, 4
	la $a0, quebra_duas_result
	syscall
	
	#Atribuindo +1 aos valores da epoca
	addi $s4, $s5, 1
	addi $s5, $s5, 1
	
	#Atribuindo +1 ao valor do registrador $s0 e retornando para o looping(While)
	addi $t0, $t0, 1
	j teste 
	
fim:


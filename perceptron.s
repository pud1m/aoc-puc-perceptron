################### NEURÔNIO PERCEPTRON ---- THALLES SALES, PUC MINAS 2020/2

################### Declaração de variáveis
.data
mes_1:            .asciiz "Insira o valor 1\n"
mes_2:            .asciiz "Insira o valor 2\n"
mes_esp:          .asciiz "Insira o resultado esperado\n"

val_1:            .word 1
val_2:            .word 1
val_esp:          .word 2
peso_1:           .float 0.8
peso_2:           .float 0.3

tx_aprend:        .float 0.05

val_check_atual:  .word 0
quant_entradas:   .word 0

loop_final_i:     .word 1
loop_final_j:     .word 1
loop_final_mes:   .asciiz "Resultados finais para todas as combinacoes de 1 e 5\n"



################### Lógica
.text
processa_entrada:
# Processa um par de entradas e retorna um novo peso
            ### Formato do que deve ser recebido:
            # t0 = val_1
            # t1 = val_2
            # t2 = val_esp
            # t8 = peso_1
            # t9 = peso_2
            ### Registradores temporários usados:
            # t3 = val_1*peso_1
            # t4 = val_2*peso_2
            # t5 = t3 - t4 (resultado atual)
            # t6 = erro
            # t7 = valor de retorno
              mul $t3, $t0, $t8
              mul $t4, $t1, $t9
              add $t5, $t3, $t4
              sub $t6, $t2, $t5
              mul $t7, $t6, tx_aprend
              mul $t7, $t7, $t0
              # RETORNO: t7

recebe_entrada:
# Insere parâmetros inputados pelo usuário nas variáveis apropriadas
              slt $t0, quant_entradas, 6
              beq $t0, $zero, retorna_resultado
              #### Imprime mensagem 1
              li $v0, 4
                la $a0, mes_1
                syscall
              # Preenche val_1
              li $v0, 5
                syscall
                sw $v0, val_1
              #### Imprime mensagem 2
              li $v0, 4
                la $a0, mes_2
                syscall
              # Preenche val_2
              li $v0, 5
                syscall
                sw $v0, val_2
              #### Imprime mensagem de valor esperado
              li $v0, 4
                la $a0, mes_esp
                syscall
              # Preenche val_esp
              li $v0, 5
                syscall
                sw $v0, val_esp

processa_entradas_router:
# Pega os dois valores de entrada, o valor esperado e os respectivos pesos, e os passa pelo processa_entrada
              bne val_check_atual, $zero, process_val_2

              #### Valor 1
              add $t0, val_1, $zero
              add $t1, val_2, $zero
              add $t2, val_esp, $zero
              add $t8, peso_1, $zero
              add $t9, peso_2, $zero
              sw $t7, peso_1
              addi $t7, val_check_atual, 1
              sw $t7, val_check_atual
              j fim_func_router

              #### Valor 2
              process_val_2:
                add $t0, val_2, $zero
                add $t1, val_1, $zero
                add $t2, val_esp, $zero
                add $t8, peso_2, $zero
                add $t9, peso_1, $zero
                sw $t7, peso_2
                sw $zero, val_check_atual
                j fim_func_router

              #### Finaliza execução da função
              # Aumenta em 1 o número de entradas processadas e pula para recebe_entrada de novo
              fim_func_router:
                addi $t7, quant_entradas, 1
                sw $t7, quant_entradas
                j recebe_entrada

retorna_resultado:
# Retorna resultados, para valores de 1 a 5, usando os pesos processados
              slt $9, loop_final_i, 

main:         
              # Imprime mensagem 1
              li $v0, 4
                la $a0, mes_1
                syscall
              # Preenche val_1
              li $v0, 5
                syscall
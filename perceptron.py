"""
  Implementação em Python do neurônio perceptron
"""

TAXA_APRENDIZADO = 0.04

def processa_entrada(v1, v2, esperado, peso_1, peso_2):
  """ Processa um par de entradas e retorna um novo peso """
  resultado_atual = v1*peso_1 + v2*peso_2
  erro = esperado - resultado_atual
  return peso_1 + (erro * TAXA_APRENDIZADO * v1)


def main():
  """ Função main """
  # Array de entradas
  entradas = []

  # Define variáveis para peso
  peso_1 = 0.5
  peso_2 = 0.3

  # Loop até preencher entradas e valores esperados
  i = 0
  print('Insira 5 pares de entrada e o resultado esperado para cada')
  while i < 5:
    print('######')
    print(f'Entrada {i+1}')
    entrada_1 = input('Insira a entrada 1: ')
    entrada_2 = input('Insira a entrada 2: ')
    entrada_3 = input('Insira o resultado esperado: ')

    entradas.append({
      'v1': int(entrada_1),
      'v2': int(entrada_2),
      'esperado': int(entrada_3)
    })
    i += 1

  # Define até qual valor o neurônio irá executar a função transformadora, depois de ser treinado
  max_val = 16

  # Loop por todos os valores inseridos para treinar o neurônio
  for entrada in entradas:
    peso_1 = processa_entrada(entrada['v1'], entrada['v2'], entrada['esperado'], peso_1, peso_2)
    peso_2 = processa_entrada(entrada['v2'], entrada['v1'], entrada['esperado'], peso_2, peso_1)
  
  # Exibe os valores calculados com o neurônio treinado
  print('\n######')
  print('Resultados processados:')
  print(f'Peso 1: {peso_1}')
  print(f'Peso 2: {peso_2}')
  print('######\n')
  i = 1
  while i <= max_val:
    for entrada in entradas:
      v1 = entrada['v1'] * i
      v2 = entrada['v2'] * i
      esperado = entrada['esperado'] * i
      resultado = v1*peso_1 + v2*peso_2
      print(f'Para os valores {v1} e {v2}. esperado/resultado: {esperado}/{resultado}')
    
    i += 1

  print('Fim do programa')


if __name__ == '__main__':
  main()

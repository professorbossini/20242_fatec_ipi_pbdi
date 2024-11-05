def exibir_pessoa(*kwargs):
  for chave, valor in kwargs.items():
    print(f'{chave}: {valor}')


exibir_pessoa(nome="Ana", idade=20)
# def somar(*args): #variadic
#   res = 0
#   print(args)
#   for arg in args:
#     res += arg
#   return res

# a = 2
# b = 3
# somar(a, b)
# print(b)
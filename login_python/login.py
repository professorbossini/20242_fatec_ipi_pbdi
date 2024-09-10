import psycopg
# print(psycopg)

class Usuario:
  def __init__(self, login, senha):
      self.login = login
      self.senha = senha

def existe(usuario):
    #abrir uma conexão com o postgresql
    with psycopg.connect(
        host="localhost",
        dbname="20242_fatec_ipi_pbdi_rodrigo",
        user="postgres",
        password="123456",
        port="5432"
    ) as conexao:
      #por meio da conexão, obter uma abstração do tipo cursor
      with conexao.cursor() as cursor:
        #por meio do cursor, executar um comando SELECT
        cursor.execute( #in-place
           'SELECT * FROM tb_usuario WHERE login=%s AND senha=%s',
           (usuario.login,usuario.senha)
        )
        #usar um método do cursor para verificar o resultado produzido pelo SELECT
        result = cursor.fetchone()
        #devolver True ou False, conforme o resultado
        return result != None
    #return True if result != None else False
    # if result != None:
    #    return True
    # return False

def menu():
  texto = "0-Fechar\n1-Login\n2-Logoff"
  usuario = None
  op = int(input(texto))
  while op != 0:
    if op == 1:
      login = input('Digite seu login\n')
      senha = input('Digite sua senha\n')
      usuario = Usuario(login, senha)
      print('Usuário OK!' if existe(usuario) else 'Usuário NOK!')
    elif op == 2:
      usuario = None
      print('Logoff realizado com sucesso')
    elif op == 3:
      #permitir o cadastro de um novo usuário
      pass
    op = int(input(texto))
  else:
     print('Até mais')
      
def main():
  menu()
  #  login = 'admina'
  #  senha = 'admin'
  #  usuario = Usuario(login, senha)
  #  print("Existe" if existe(usuario) else "Não existe")

main()
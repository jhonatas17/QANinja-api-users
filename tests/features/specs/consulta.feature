#language: pt

@get
Funcionalidade:  Consulta de usuários

Cenario:  Obter lista de usuários

 Quando faço uma consulta
 Então o código de resposta deve ser "200"
   E o sistema retorna uma lista de usuários cadastrados 

Cenario: Obter um único usuário

  Dado que eu tenho um usuário cadastrado
  Quando faço a consulta desse usuário
  Então o código de resposta deve ser "200"
     E o sistema retorna os dados desse usuário

 Cenario: Usuário não cadastrado
   Dado que o usuário não esta cadastrado
   Quando faço a consulta desse usuário
   Então o código de resposta deve ser "404"
      E vejo a mensagem "Usuário não encontrado!"
      
 
  Cenario: Consulta por email do usuário
   Dado que eu tenho um usuário cadastrado
   Quando faço a consulta desse usuário por email
   Então o código de resposta deve ser "200"
      E o sistema retorna os dados desse usuário
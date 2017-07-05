#language: pt

@delete
Funcionalidade: Remover usuário

@new_user  
Cenario: Remover usuário cadastrado
    
    Quando faço a exclusão pelo identificador do usuário
    Então o código de resposta deve ser "200"
      E esse usuário não deve ser exibido na consulta

Cenario: Usuário não cadastrado 
   
   Dado que o usuário não esta cadastrado
   Quando faço a exclusão pelo identificador do usuário
   Então o código de resposta deve ser "404"
      E vejo a mensagem "Usuário não encontrado!"
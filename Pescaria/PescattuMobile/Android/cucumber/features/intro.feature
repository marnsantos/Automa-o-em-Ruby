#language:pt

Funcionalidade: Login
    Sendo eu um usuário do aplicativo Pescattu
    Ao informar meu cpf e senha
    Devo ser autenticado como usuário do aplicativo

   
    Cenario: Login do usuário
        Dado que acesso o formulario de login
        Quando faço login com "75585600206" e "123456"
        Então devo ser autenticado e ver Ofertas e Produtos
    
    
    # Cenario: Senha incorreta
    #     Dado que acesso o formulario de login
    #     Quando faço login com "oi@teste.com.br" e "123456"
    #     Então devo ver a mensagem de alerta "Login ou senha inválido"

    # Cenario: Email invalido
    #     Dado que acesso o formulario de login
    #     Quando faço login com "testes.com.br" e "123456"
    #     Então devo ver a mensagem de alerta "Login ou senha inválido"

    
    # Cenario: Campo email em branco
    #     Dado que acesso o formulario de login
    #     Quando faço login com " " e "123456"
    #     Então devo ver a mensagem de alerta "Login ou senha inválido"
    
  
    # Esquema do Cenario: Login sem sucesso

    #     Quando faço login com "<email>" e "<senha>"
    #     Então vejo a seguinte mensagem "<mensagem>"

    #     Exemplos:
    #     | email                     | senha  | mensagem                      |
    #     | eu@teste.io               | 111111 | Usuário e/ou senha inválidos. |
    #     | padrekevedo@noekziste.com | 123456 | Usuário e/ou senha inválidos. |
    #     | email#gmail.com           | 111222 | Email inválido.               |
  
    # Cenario: Usuario tentando logar

    #     Quando tento logar com os seguintes dados:
    #         | email           | senha  |
    #         | eu@teste.io     | 111111 |
    #         | eu@teste.com    | 123456 |
    #         | eu@test.io      | 111222 |
    #     Então devo ver as seguintes mensagens:
    #         | mensagem                      |
    #         | Usuário e/ou senha inválidos. |
    #         | Usuário e/ou senha inválidos. |
    #         | Email inválido.               | 
   

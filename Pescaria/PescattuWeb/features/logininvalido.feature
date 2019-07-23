#language:pt
@login-invalido
Funcionalidade: Login
    Sendo eu um usuário do sistema Pescattu
    Ao informar email e senha invalido
    Não deve permitir acesso ao sistema
    
    
    Esquema do Cenario: Validação de login
        Dado que tento realizar login com "<email>" e "<senha>"
        Então deve exibir mensagem "<mensagem>"    


    Exemplos:
        |    email        |   senha  |        mensagem                    |
        | web_@gmail.com  | 123456   | Login ou senha inválido            |
        | web@gmail.com   | 1234     | Login ou senha inválido            |
        | oi@teste.com.br | 123456   | Login ou senha inválido            |
        | testes.com.br   | 123456   | CPF inválido, dígitos não conferem.|

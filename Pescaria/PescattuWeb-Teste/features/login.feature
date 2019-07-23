#language:pt
@login
Funcionalidade: Login
    Sendo eu um usuário do sistema Pescattu
    Ao informar meu email e senha
    Devo ter acesso ao sistema
    
    
    Esquema do Cenario: Login do usuário
        Dado que faço login com "<email>" e "<senha>"
        Então devo ver a logo "<logo>"    


    Exemplos:
        |    email      | senha  | logo           |
        | web@gmail.com | 123456 | Pescattu       |
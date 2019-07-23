#language: pt
@auth @cadreceita 
Funcionalidade: Receitas
    Sendo um usuário admin do sistema Pescattu
    Ao cadastrar uma receita
    Devo ter a receita cadastrada

    Esquema do Cenario: Cadastrar receita

        Dado que faço o cadastro da seguinte receita "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>"
        E adiciono os ingredientes "<ingrediente>"
        Quando informo os passos "<passo>"
        Entao deve exibir uma mensagem "<mensagem>"
   
    Exemplos:
        | nome                |tempo       | qtdpessoas      | descricao   |  ingrediente        | passo     | mensagem                         |
        | Tartaruga assada    |120         | 15              |Teste        | ingrediente 1       |   passo 1 | Receita cadastrada com sucesso. |
      
    
    Esquema do Cenario: Campos em branco

        Dado que submeto campos em branco no cadastro de receita "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>" 
        Entao deve exibir um alerta de campo obrigatório "<mensagem_alerta>"

    Exemplos:
        | nome                |tempo      | qtdpessoas      | descricao   |  ingrediente        | passo     |  mensagem_alerta    |
        |                     |12         | 15              |Teste        | ingrediente 1       |   passo 1 | Campo obrigatório   |
        |   Carne assada      |           | 15              |Teste        | ingrediente 1       |   passo 1 | Campo obrigatório   |
        |   Carne assada      |12         |                 |Teste        | ingrediente 1       |   passo 1 | Campo obrigatório   |
        |   Carne assada      |15         | 15              |             | ingrediente 1       |   passo 1 | Campo obrigatório   |
    
 
    Esquema do Cenario: Realizar cadastro sem adicionar ingredientes e passos na receita
        Dado que faço o cadastro da seguinte receita "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>"
        Quando incluo o ingrediente e passo "<ingrediente>", "<passo>" 
        Entao deve exibir um alerta de erro "<alerta_error>"
    
    Exemplos:
        | nome                |tempo      | qtdpessoas      | descricao   |  ingrediente        | passo     |  alerta_error                                         |
        |   Carne assada      |12         | 15              |Teste        |   ingrediente 1     |           | A receita deve ter ao menos um passo e um ingrediente |
        |   Carne assada      |12         | 15              |Teste        |                     |   passo 1 | A receita deve ter ao menos um passo e um ingrediente |
      

    # Esquema do Cenario: Cadastrar receita adicionando N ingredientes e N passos
    #     Dado que faço o cadastro da seguinte receita "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>"
    #     Quando incluo os ingredientes e os seus respectivos passos
    #     |  ingrediente          |passo                  |
    #     |    Macarrão           |Leve ao liquidificador |
    #     Entao deve solicitar a inclusão dos campos atraves do alerta "<alerta_error>"

    # Exemplos:
    #      | nome                |tempo      | qtdpessoas      | descricao   |  alerta_error                                          |
    #      |   Carne assada      |12         | 15              |Teste        |  A receita deve ter ao menos um passo e um ingrediente |
    #      |   Carne assada      |12         | 15              |Teste        |  A receita deve ter ao menos um passo e um ingrediente |
    
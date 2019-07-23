#language: pt
@auth @updatereceita 
Funcionalidade: Receitas
    Sendo um usuário admin do sistema Pescattu
    Ao editar uma receita
    Devo ter a receita editada

    # Esquema do Cenario: Editar receita

    #     Dado que altero a seguinte receita "<receita>"
    #     E que faço alteração para "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>"
    #     E adicionando os seguintes ingredientes "<ingrediente>"
    #     Quando informo os respectivos passos "<passo>"
    #     Entao deve apresentar a mensagem "<mensagem>"
   
    # Exemplos:
    #    |receita       | nome                |tempo       | qtdpessoas      | descricao   |  ingrediente        | passo     | mensagem                         |
    #    | Jacaré       | Camarão             |120         | 15              |Teste        | ingrediente 1       |   passo 1 | Receita cadastrada com sucesso.  |
    #    | Camarão      | Jacaré              |120         | 15              |Teste        | ingrediente 1       |   passo 1 | Receita cadastrada com sucesso.  |
      
    
    Esquema do Cenario: Campos em branco na edição


        Dado que altero a seguinte receita "<receita>"
        Quando submeto campos em branco na alteração de receita "<nome>", "<tempo>", "<qtdpessoas>", "<descricao>" 
        Entao deve apresentar alerta de campo obrigatório "<mensagem_alerta>"

    Exemplos:
        |receita | nome            |tempo      | qtdpessoas      | descricao       |  mensagem_alerta    |
        |Jacaré  |                 |12         |        120      |          gjgj   | Campo obrigatório   |
        # | Jacaré | Carne assada      |           | 15              |Teste        | ingrediente 1       |   passo 1 | Campo obrigatório   |
        # | Jacaré | Carne assada      |12         |                 |Teste        | ingrediente 1       |   passo 1 | Campo obrigatório   |
        # | Jacaré | Carne assada      |15         | 15              |             | ingrediente 1       |   passo 1 | Campo obrigatório   |
    

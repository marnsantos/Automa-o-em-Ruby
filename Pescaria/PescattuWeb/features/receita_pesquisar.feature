#language: pt

@receitas_doing @auth
Funcionalidade: Pesquisar receitas
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para pesquisar receitas

    Cenario: Pesquisar receitas
        Dado que eu consulto a receita: 'Tartaruga assada'
        Entao retorna a consulta com 2 itens
    
    # Cenario: Visualizar mensagem item não encontrado
    #     Dado que eu consulto uma receita: 'xxx'
    #     Entao retorna na consulta 
    #     """
    #     Item não encontrado.
    #     """  
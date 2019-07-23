#language: pt
@pesquisar @auth
Funcionalidade: Pesquisar produto
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para pesquisar produto

    
    Cenario: Pesquisar produto
        Dado que eu pesquiso o seguinte produto: 'P'
        Entao devo vejo no resultado da pesquisa 7 itens

    
    Cenario: Pesquisar por codigo
        Dado que eu pesquiso o seguinte produto por codigo: '12312312'
        Entao devo vejo no resultado da pesquisa '12312312'

    
    Cenario: Visualizar mensagem item não encontrado
        Dado que eu pesquiso o produto: 'xxx'
        Entao vejo no resultado da pesquisa 
        """
        Item não encontrado.
        """ 
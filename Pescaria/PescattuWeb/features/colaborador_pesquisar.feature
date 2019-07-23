#language: pt
@auth @done 
Funcionalidade: Pesquisar colaborador
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para pesquisar os colaboradores

    
    Cenario: Pesquisar colaborador
        Dado que pesquiso colaborador: 'VANESSA DA SILVA'
        Entao devo obter resultado da pesquisa 3 itens

    
    Cenario: Pesquisar colaborador por codigo
        Dado que eu pesquiso o colaborador por codigo: '1024'
        Entao devo obter resultado da pesquisa '1024'

    
    Cenario: Visualizar mensagem item não encontrado
        Dado que ao pesquisar colaborador: 'xxxxx'
        Entao tenho resultado da pesquisa 
        """
        Item não encontrado.
        """ 
#language: pt
@pesq_empresa @auth
Funcionalidade: Pesquisar empresa
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para pesquisar empresas

    
    Cenario: Pesquisar produto
        Dado que eu pesquiso a empresa: 'Bemol'
        Entao deve vir resultado da pesquisa 4 itens

    
    Cenario: Pesquisar por codigo
        Dado que eu pesquiso a empresa por codigo: '17.661.017/0001-92'
        Entao deve exibir resultado da pesquisa '17.661.017/0001-92'

    
    Cenario: Visualizar mensagem item não encontrado
        Dado que pesquiso a empresa: 'xxx'
        Entao vejo o resultado da pesquisa 
        """
        Item não encontrado.
        """  
#language: pt

@auth @doing 
Funcionalidade: Categoria de Produtos
    Sendo um usuário admin do sistema Pescattu
    Ao cadastrar uma categoria de produto
    Devo ter categoria de produto cadastrada com sucesso

    
    Esquema do Cenario: Cadastrar categoria de produto

        Dado que faço o cadastro da categoria "<categoria>"
        Entao exibe uma mensagem "<mensagem>"
   
    Exemplos:
        | categoria        |mensagem                              |
        | Corte            |Categoria criada com sucesso.         | 
        | Filé             |Categoria já cadastrada no sistema.   |
        
    
    Esquema do Cenario: Campos em branco

        Dado que submeto campos em branco no cadastro da categoria "<categoria>"     
        Entao deve apresentar alerta "<mensagem_alerta>"
   
    Exemplos:
        | categoria        |mensagem_alerta    |
        |                  |Campo obrigatório  |
      
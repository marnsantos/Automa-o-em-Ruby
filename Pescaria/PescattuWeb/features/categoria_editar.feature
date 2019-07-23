#language: pt
@auth @categoria_alt 
Funcionalidade: Categoria de Produtos
    Sendo um usuário admin do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para editar categoria de produto cadastrada com sucesso

    
    Esquema do Cenario: Editar categoria de produto

        Dado que seleciono a categoria "<categoria>"
        Quando edito esta categoria "<cat_editar>"
        Entao exibe mensagem "<mensagem>"
   
    Exemplos:
        | categoria     | cat_editar          |mensagem                            |
        | Postas        |  Posta 1            |Categoria criada com sucesso.       | 
     
 
    # Esquema do Cenario: Campos em branco

    #     Dado que submeto campos em branco no cadastro da categoria "<categoria>"     
    #     Entao deve apresentar alerta "<mensagem_alerta>"
   
    # Exemplos:
    #     | categoria        |mensagem_alerta    |
    #     |                  |Campo obrigatório  |
      
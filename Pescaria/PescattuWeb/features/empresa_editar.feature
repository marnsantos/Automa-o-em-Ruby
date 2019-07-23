#language: pt
@auth @doni
Funcionalidade: Editar Empresa
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para editar empresa

    
    Esquema do Cenario: Editar empresa
        Dado que possuo a empresa "<empresa>"
        Quando edito esta empresa "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"
        Entao devo ver "<mensagem>"

    Exemplos:
        | empresa         | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem                    |
        |  BEMO           | Manaus             | BEMOL           | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Empresa salva com sucesso.  |
        |  BEMOL          | Manaus             | BEMO            | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Empresa salva com sucesso.  |
       
    # Esquema do Cenario: Validar edição de campos em branco
        
    #     Dado que possuo a empresa "<empresa>"
    #     Quando submeto campos em branco no cadastro de empresas "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"     
    #     Entao exibe alerta "<mensagem_alerta>"
        
    # Exemplos:
    #     |empresa                                         | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem_alerta     |
    #     |INDT - INSTITUTO DE DESENVOLVIMENTO TECNOLOGICO | Manaus             |                 | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
    #     # |INDT - INSTITUTO DE DESENVOLVIMENTO TECNOLOGICO | Anori              |Belota           |                    |bemol.com.br     |92999999999   |Belota       | Rua J            | 140     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
    #     # |INDT - INSTITUTO DE DESENVOLVIMENTO TECNOLOGICO | Manaus             |Bemol Ltda       | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       |                  | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
    #     # |INDT - INSTITUTO DE DESENVOLVIMENTO TECNOLOGICO | Anori              |Belota           | 90.192.042/0001-06 |bemol.com.br     |92999999999   |Belota       | Rua J            |         | Dom Pedro I  |69037144  |              |Campo obrigatório   |
    #     # |INDT - INSTITUTO DE DESENVOLVIMENTO TECNOLOGICO | Tabatinga          |Bemol            | 48.192.042/0001-06 |bemol.com.br     |92985647865   | Bemol       | Rua Areosa       | 145     |              |69037144  |              |Campo obrigatório   |
       
   
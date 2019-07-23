#language: pt
@doing @auth
Funcionalidade: Editar Empresa
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para editar empresa

    
    Esquema do Cenario: Editar empresa
        Dado que possuo a empresa "<empresa>"
        Quando edito esta empresa "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"
        Entao devo ver "<mensagem>"

    Exemplos:
        | empresa    | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem                    |
        |  empresa   | Manaus             | INSTITUTO TALK  | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Empresa salva com sucesso.  |
        |  instituto | Manaus             | EMPRESA AREOSA  | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Empresa salva com sucesso.  |
       
    Esquema do Cenario: Validar edição de campos em branco
        
        Dado que possuo a empresa "<empresa>"
        Quando submeto campos em branco no cadastro de empresas "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"     
        Entao exibe alerta "<mensagem_alerta>"
        
    Exemplos:
        |empresa        | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem_alerta     |
        |empresa        | Manaus             |                 | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        # |empresa        | Anori              |Belota           |                    |bemol.com.br     |92999999999   |Belota       | Rua J            | 140     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        # |empresa        | Manaus             |Bemol Ltda       | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       |                  | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        # |empresa        | Anori              |Belota           | 90.192.042/0001-06 |bemol.com.br     |92999999999   |Belota       | Rua J            |         | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        # |empresa        | Tabatinga          |Bemol            | 48.192.042/0001-06 |bemol.com.br     |92985647865   | Bemol       | Rua Areosa       | 145     |              |69037144  |              |Campo obrigatório   |
       
   
#language: pt
@auth @empresa
Funcionalidade: Empresa
    Sendo um usuário admin do sistema Pescattu
    Ao cadastrar uma Empresa
    Devo ter empresa cadastrada

    
    Esquema do Cenario: Cadastrar empresa

        Dado que cadastro a seguinte empresa "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"
        Entao exibir a mensagem "<mensagem>"
   
    Exemplos:
        | cidade             |nome                | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem                    |
        | Manaus             |Teste 5 Ltda        | 16.031.250/0001-29 |testeda.com.br   |92985647865   | Teste       | Rua Areosa       | 145     | Alvorada  I  |69037144  |              |Empresa salva com sucesso.  |
        | Anori              |Belota              | 90.192.042/0003-06 |bemol.com.br     |92999999999   |Belota       | Rua J            | 140     | Dom Pedro I  |69037144  |              |CNPJ inválido               |
        | Tabatinga          |Bemol               | 48.192.042/0001-06 |bemol.com.br     |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Nome já cadastrado.         |
       
   
    Esquema do Cenario: Campos em branco

        Dado que submeto campos em branco no cadastro de empresas "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"     
        Entao exibir o alerta "<mensagem_alerta>"
    Exemplos:
        | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem_alerta     |
        | Manaus             |                 | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        | Anori              |Belota           |                    |bemol.com.br     |92999999999   |Belota       | Rua J            | 140     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        | Manaus             |Bemol Ltda       | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       |                  | 145     | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        | Anori              |Belota           | 90.192.042/0001-06 |bemol.com.br     |92999999999   |Belota       | Rua J            |         | Dom Pedro I  |69037144  |              |Campo obrigatório   |
        | Tabatinga          |Bemol            | 48.192.042/0001-06 |bemol.com.br     |92985647865   | Bemol       | Rua Areosa       | 145     |              |69037144  |              |Campo obrigatório   |
       
   
    Esquema do Cenario: Cancelar cadastro de empresa
        Dado que cadastro a empresa "<cidade>", "<nome>", "<cnpj>", "<url>", "<telefone>", "<contato>", "<rua>", "<numero>", "<bairro>", "<cep>", "<complemento>"
        Entao cancelo a operação devo retornar para lista de empresas "<titulo>"
    Exemplos:
        | cidade             |nome             | cnpj               | url             | telefone     | contato     | rua              | numero  | bairro       | cep      | complemento  |mensagem                    |titulo    |
        | Manaus             |Bemol Teste      | 48.192.042/0001-06 |bemolda.com.br   |92985647865   | Bemol       | Rua Areosa       | 145     | Dom Pedro I  |69037144  |              |Empresa salva com sucesso.  | Pesquisar|
      
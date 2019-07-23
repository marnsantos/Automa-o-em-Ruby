#language: pt
@auth @produto 
Funcionalidade: Produto
    Sendo um usuário admin do sistema Pescattu
    Ao cadastrar um produto
    Devo ter o produto cadastrado

    
    Esquema do Cenario: Cadastrar produto

        Dado que faço o cadastro do seguinte produto "<nome>", "<categoria>", "<ean>", "<codigo>", "<tamanho>", "<peso>", "<descricao>", "<proteina>", "<gordura>", "<energetico>", "<freezer>", "<geladeira>", "<preco_aplicativo>", "<preco_varejo>", "preco_embalagem", "preco_licenca"
        Entao deve exibir a mensagem "<mensagem>"
   
    Exemplos:
        | nome             |categoria          | ean             | codigo  | tamanho | peso | descricao              | proteina | gordura | energetico | freezer | geladeira | preco_aplicativo | preco_varejo | preco_embalagem   | preco_licenca   |mensagem                        |
        | Tartaruga 6      |FRESCO             | 4460945220024   |0155     | g       | 100  | Peixe de qualidade     | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 40,00        |       2,00        |     30,00       | Produto cadastrado com sucesso.|
        | Teste 99803      |SALGADO            | 40935275934270  |0137     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     20,00       | Codigo já cadastrado.          |
        | Teste 99800      |CONGELADO          | 48935275934270  |0140     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     10,00       | Nome já cadastrado.            |
       
    
    Esquema do Cenario: Campos em branco

        Dado que submeto campos em branco no cadastro de produto "<nome>", "<categoria>", "<ean>", "<codigo>", "<tamanho>", "<peso>", "<descricao>", "<proteina>", "<gordura>", "<energetico>", "<freezer>", "<geladeira>", "<preco_aplicativo>", "<preco_varejo>", "preco_embalagem", "preco_licenca"     
        Entao deve exibir o alerta "<mensagem_alerta>"
    Exemplos:
        | nome             |categoria          | ean             | codigo  | tamanho | peso | descricao              | proteina | gordura | energetico | freezer | geladeira | preco_aplicativo | preco_varejo | preco_embalagem   | preco_licenca   |mensagem_alerta                |
        |                  |FRESCO             | 489352788934270 |0148     | g       | 100  | Peixe de qualidade     | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 40,00        |       2,00        |     30,00       |Campo obrigatório              |
        | Teste 99800      |CONGELADO          | 48935275934270  |         | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     10,00       |Campo obrigatório              |
        | Teste 99803      |SALGADO            | 40935275934270  |0137     | g       | 100  |                        | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     20,00       |Campo obrigatório              |
        | Teste 99800      |CONGELADO          | 48935275934270  |0140     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         |                  | 10,00        |       2,00        |     10,00       |Campo obrigatório              |
        | Teste 99803      |SALGADO            | 40935275934270  |0137     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            |              |       2,00        |     20,00       |Campo obrigatório              |
       
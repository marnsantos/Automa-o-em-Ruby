#language: pt
@editar @auth
Funcionalidade: Produto
    Sendo um usuário do sistema Pescattu
    Ao logar na aplicação, devo possuir acesso para editar produto

    
    Esquema do Cenario: Editar produto
        Dado que possuo o seguinte produto "<produto>"
        Quando edito este produto "<nome>", "<categoria>", "<ean>", "<codigo>", "<tamanho>", "<peso>", "<descricao>", "<proteina>", "<gordura>", "<energetico>", "<freezer>", "<geladeira>", "<preco_aplicativo>", "<preco_varejo>", "preco_embalagem", "preco_licenca"
        Entao a mensagem "<mensagem>" é exibida

    Exemplos:
       |produto | nome            |categoria          | ean             | codigo  | tamanho | peso | descricao              | proteina | gordura | energetico | freezer | geladeira | preco_aplicativo | preco_varejo | preco_embalagem   | preco_licenca   |mensagem                       |
       | 0145   | Camarão Rosado  |Salgado            | 489352788934270 |19       | g       | 100  | Peixe de qualidade     | 1,0      | 1,8     | 2,5        | 5       | 2         | 20,00            | 40,00        |       5,00        |     50,00       |Produto cadastrado com sucesso.|
       | 19     | Camarão Azulado |Fresco             | 40935275934270  |0145     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     20,00       |Produto cadastrado com sucesso.|
       | 41     | Camarão         |Congelado          | 48935275934270  |0140     | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     10,00       |Nome já cadastrado.            |
       | 21     | Teste 0987      |Congelado          | 48935275934270  |41       | g       | 100  | Peixe de boa qualidade | 1,5      | 1,8     | 2,5        | 5       | 2         | 20,00            | 10,00        |       2,00        |     10,00       |Codigo já cadastrado.          | 
        
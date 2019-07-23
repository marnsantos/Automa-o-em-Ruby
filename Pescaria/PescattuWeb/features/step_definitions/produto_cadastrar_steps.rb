Dado('que faço o cadastro do seguinte produto {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca|
  produto_cadastrar_page.load
  produto_cadastrar_page.cadastrar(nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca)
end

Entao('deve exibir a mensagem {string}') do |mensagem|
  expect(produto_list_page.alerta_messagem.find('strong').text).to eql mensagem
end

Dado('que submeto campos em branco no cadastro de produto {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca|
  produto_cadastrar_page.load
  produto_cadastrar_page.cadastrar(nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca)
end

Entao('deve exibir o alerta {string}') do |alertar|
  expect(produto_list_page.campo_obrigatorio.text).to eql alertar
end
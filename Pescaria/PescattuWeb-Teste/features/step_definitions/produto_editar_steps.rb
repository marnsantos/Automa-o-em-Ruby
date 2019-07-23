Dado('que possuo o seguinte produto {string}') do |produto|
  @produto = produto
  produto_editar_page.load
  @resultado = produto_editar_page.pesquisar(produto)
end

Quando('edito este produto {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}, {string}') do |nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca|
  produto_editar_page.alterar_produto(@resultado, nome, categoria, ean, codigo, tamanho, peso, descricao, proteina, gordura, energetico, freezer, geladeira, preco_aplicativo, preco_varejo, preco_embalagem, preco_licenca)
end

Entao('a mensagem {string} é exibida') do |mensagem|
  expect(produto_editar_page.alerta_messagem.text).to have_content mensagem
end

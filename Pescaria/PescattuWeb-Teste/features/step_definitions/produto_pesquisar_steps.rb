Dado('que eu pesquiso o seguinte produto: {string}') do |produto|
  @produto = produto
  produto_pesquisar_page.load
  @resultado = produto_pesquisar_page.pesquisar_produto(produto)
end

Dado('que eu pesquiso o seguinte produto por codigo: {string}') do |produto|
  @produto = produto
  produto_pesquisar_page.load
  @resultado = produto_pesquisar_page.pesquisa_por_codigo(produto)
end

Dado('que eu pesquiso o produto: {string}') do |produto|
  @produto = produto
  produto_pesquisar_page.load
  @mensagem_visualizada = produto_pesquisar_page.item_nao_encontrado(produto)
end

Entao('devo vejo no resultado da pesquisa {int} itens') do |quantidade|
  expect(@resultado).to eql quantidade
end

Entao('devo vejo no resultado da pesquisa {string}') do |resultado_codigo|
  expect(@resultado).to have_content resultado_codigo
end

Entao('vejo no resultado da pesquisa') do |mensagem|
  expect(@mensagem_visualizada.text).to eql mensagem
end

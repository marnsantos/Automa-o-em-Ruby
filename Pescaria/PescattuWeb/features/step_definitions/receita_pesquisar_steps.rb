Dado('que eu consulto a receita: {string}') do |receita|
  @receita = receita
  receita_pesquisar_page.load
  @resultado = receita_pesquisar_page.pesquisar_receita(receita)
end

Dado('que eu consulto uma receita: {string}') do |receita|
  @receita = receita
  receita_pesquisar_page.load
  @mensagem_visualizada = receita_pesquisar_page.item_nao_encontrado(receita)
end

Entao('retorna a consulta com {int} itens') do |quantidade|
  expect(@resultado).to eql quantidade
end

Entao('retorna na consulta') do |mensagem|
  expect(@mensagem_visualizada.text).to eql mensagem
end

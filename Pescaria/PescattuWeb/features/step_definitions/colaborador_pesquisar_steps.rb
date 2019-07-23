Dado('que pesquiso colaborador: {string}') do |colaborador|
  @colaborador = colaborador
  colaborador_pesquisar_page.load
  @resultado = colaborador_pesquisar_page.pesquisar_colaborador(colaborador)
end

Dado('que ao pesquisar colaborador: {string}') do |colaborador|
  @colaborador = colaborador
  colaborador_pesquisar_page.load
  @mensagem = colaborador_pesquisar_page.item_n_encontrado(colaborador)
end

Dado('que eu pesquiso o colaborador por codigo: {string}') do |colaborador|
  @colaborador = colaborador
  colaborador_pesquisar_page.load
  @result_cod = colaborador_pesquisar_page.pesquisar_colaborador_codigo(colaborador)
end

Entao('devo obter resultado da pesquisa {int} itens') do |qtd_colaborador|
  expect(@resultado).to eql qtd_colaborador
end

Entao('devo obter resultado da pesquisa {string}') do |resu_codigo|
  expect(@result_cod).to have_content resu_codigo
end

Entao('tenho resultado da pesquisa') do |mensagem_co|
  expect(@mensagem.text).to eql mensagem_co
end
